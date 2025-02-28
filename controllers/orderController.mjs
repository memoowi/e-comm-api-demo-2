import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const makeOrder = async (req, res) => {
  const userId = req.user.id;
  const { addressId, items } = req.body;

  if (!addressId || !items || !Array.isArray(items) || items.length === 0) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "addressId and items (as an array) are required",
    });
  }

  try {
    const [existingAddress] = await db.execute(
      "SELECT * FROM addresses WHERE user_id = ? AND id = ?",
      [userId, addressId]
    );

    if (existingAddress.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "Address not found",
      });
    }

    // 1. Transaction Start
    await db.beginTransaction();

    try {
      let totalPrice = 0;
      const orderItems = [];

      // 2. Stock Check and Product Details Retrieval (within the same loop)
      for (const item of items) {
        const [product] = await db.execute(
          "SELECT * FROM products WHERE id = ?",
          [item.productId]
        );

        if (product.length === 0) {
          throw new Error(`Product with ID ${item.productId} not found.`); // Throw error to rollback
        }

        if (product[0].stock < item.quantity) {
          throw new Error(
            `Insufficient stock for product ID ${item.productId}.`
          ); // Throw error to rollback
        }

        totalPrice += product[0].price * item.quantity;
        orderItems.push({
          productId: item.productId,
          quantity: item.quantity,
          price: product[0].price,
          product: product[0], // Include product details for the final response
        });
      }

      // 3. Insert into orders table
      const [order] = await db.execute(
        "INSERT INTO orders (user_id, total_price) VALUES (?, ?)",
        [userId, totalPrice]
      );
      const orderId = order.insertId; // Capture orderId

      // 4. Insert into order_items table (using a single query with placeholders)
      const orderItemsValues = orderItems.map((item) => [
        orderId,
        item.productId,
        item.quantity,
        item.price,
      ]);

      await db.execute(
        "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES ?",
        [orderItemsValues]
      );

      // 5. Insert into order_addresses table
      await db.execute(
        "INSERT INTO order_addresses (order_id, address, subdistrict, district, regency, province, postal_code, country, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          orderId,
          existingAddress[0].address,
          existingAddress[0].subdistrict,
          existingAddress[0].district,
          existingAddress[0].regency,
          existingAddress[0].province,
          existingAddress[0].postal_code,
          existingAddress[0].country,
          existingAddress[0].phone,
        ]
      );

      // 6. Update product stock (after successful order creation)
      const updateStockPromises = orderItems.map((item) =>
        db.execute("UPDATE products SET stock = stock - ? WHERE id = ?", [
          item.quantity,
          item.productId,
        ])
      );
      await Promise.all(updateStockPromises); // Run stock updates concurrently

      // 7. Fetch combined order data for response
      const [orderData] = await db.execute(
        "SELECT o.*, oa.*, oi.*, p.name as product_name, p.description as product_description, p.price as product_price  FROM orders o JOIN order_addresses oa ON o.id = oa.order_id JOIN order_items oi ON o.id = oi.order_id JOIN products p ON oi.product_id = p.id WHERE o.id = ?",
        [orderId]
      );

      // 8. Transaction Commit
      await db.commit();

      successResponse({
        res,
        statusCode: 201,
        message: "Order created successfully",
        data: {
          ...orderData[0], // Spread order and address data
          items: orderItems, // Include item details in the response
        },
      });
    } catch (error) {
      // 9. Transaction Rollback on Error
      await db.rollback();
      console.error("Order Creation Error:", error);

      if (
        error.message.startsWith("Product with ID") ||
        error.message.startsWith("Insufficient stock")
      ) {
        return errorResponse({ res, statusCode: 400, message: error.message });
      }

      errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
    }
  } catch (error) {
    console.error("Database Error:", error);
    errorResponse({
      res,
      statusCode: 500,
      message: "Database error occurred.",
    });
  }
};
