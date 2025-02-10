import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const addCart = async (req, res) => {
  const userId = req.user.id;
  const { productId, quantity } = req.body;

  if (!productId || !quantity) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "productId and quantity are required",
    });
  }

  try {
    const [product] = await db.execute("SELECT * FROM products WHERE id = ?", [
      productId,
    ]);

    if (product.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "Product not found",
      });
    }

    const [cart] = await db.execute(
      "SELECT * FROM carts WHERE user_id = ? AND product_id = ?",
      [userId, productId]
    );

    if (cart.length > 0) {
      // Update the quantity of the existing cart item
      const [result] = await db.execute(
        "UPDATE carts SET quantity = ? WHERE user_id = ? AND product_id = ?",
        [quantity, userId, productId]
      );

      successResponse({
        res,
        statusCode: 200,
        message: "Product quantity updated in cart successfully",
        // data: result,
      });
      return;
    }

    const [result] = await db.execute(
      "INSERT INTO carts (user_id, product_id, quantity) VALUES (?, ?, ?)",
      [userId, productId, quantity]
    );

    successResponse({
      res,
      statusCode: 201,
      message: "Product added to cart successfully",
      //   data: result,
    });
  } catch (error) {
    console.error(error);
    errorResponse({
      res,
      statusCode: 500,
      message: "Internal Server Error",
    });
  }
};

export const getCart = async (req, res) => {
  const userId = req.user.id;

  try {
    const [rows] = await db.execute(
      "SELECT p.*, c.quantity FROM products p LEFT JOIN carts c ON p.id = c.product_id WHERE c.user_id = ?",
      [userId]
    );

    successResponse({
      res,
      statusCode: 200,
      message: "Success fetching cart data",
      data: rows,
    });
  } catch (error) {
    console.error(error);
    errorResponse({
      res,
      statusCode: 500,
      message: "Internal Server Error",
    });
  }
};

export const deleteCart = async (req, res) => {
  const userId = req.user.id;
  const { productId } = req.body;

  try {
    const [result] = await db.execute(
      "DELETE FROM carts WHERE user_id = ? AND product_id = ?",
      [userId, productId]
    );

    successResponse({
      res,
      statusCode: 200,
      message: "Product removed from cart successfully",
      // data: result,
    });
  } catch (error) {
    console.error(error);
    errorResponse({
      res,
      statusCode: 500,
      message: "Internal Server Error",
    });
  }
};
