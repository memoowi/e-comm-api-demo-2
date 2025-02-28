import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const addCart = async (req, res) => {
  const userId = req.user.id;
  const { productId, variant = null, quantity } = req.body;

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
    // check if variant is valid
    const variantData = JSON.parse(product[0].variant);

    // check if product has variants, if so make variant field required and check if variant is valid
    if (variantData.length > 0) {
      if (!variant) {
        return errorResponse({
          res,
          statusCode: 400,
          message: "variant is required",
        });
      }
      if (!variantData.includes(variant)) {
        return errorResponse({
          res,
          statusCode: 400,
          message: "Invalid variant",
        });
      }
    }

    let cart = [];
    if (variant) {
      [cart] = await db.execute(
        "SELECT * FROM carts WHERE user_id = ? AND product_id = ? AND variant = ?",
        [userId, productId, variant]
      );
    } else {
      [cart] = await db.execute(
        "SELECT * FROM carts WHERE user_id = ? AND product_id = ?",
        [userId, productId]
      );
    }

    console.log(cart);

    if (cart.length > 0) {
      // update quantity based on variant
      if (cart[0].variant === variant) {
        const [result] = await db.execute(
          "UPDATE carts SET quantity = ? WHERE id = ? ",
          [quantity, cart[0].id]
        );
        successResponse({
          res,
          statusCode: 200,
          message: "Product quantity updated in cart successfully",
          // data: result,
        });
        return;
      }
    }

    const [result] = await db.execute(
      "INSERT INTO carts (user_id, product_id, variant, quantity) VALUES (?, ?, ?, ?)",
      [userId, productId, variant, quantity]
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
      "SELECT p.*, c.id as cart_id, c.quantity, c.variant FROM products p LEFT JOIN carts c ON p.id = c.product_id WHERE c.user_id = ?",
      [userId]
    );

    successResponse({
      res,
      statusCode: 200,
      message: "Success fetching cart data",
      data: rows.map((item) => ({
        ...item,
        // variant: JSON.parse(item.variant),
        img_urls: JSON.parse(item.img_urls),
      })),
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
  const { cartId } = req.body;

  try {
    const [result] = await db.execute(
      "DELETE FROM carts WHERE user_id = ? AND id = ?",
      [userId, cartId]
    );

    if (result.affectedRows === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "Cart not found",
      });
    }

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
