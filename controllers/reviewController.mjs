import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const addReview = async (req, res) => {
    try {
      const userId = req.user.id;
    const { productId, rating, comment } = req.body;

    if (!productId || !rating || !comment) {
      return errorResponse({
        res,
        statusCode: 400,
        message: "productId, rating, and comment are required",
      });
    }

    if (rating < 1 || rating > 5) {
      return errorResponse({
        res,
        statusCode: 400,
        message: "Rating must be between 1 and 5",
      });
    }

    const [product] = await db.execute(
      "SELECT id FROM products WHERE id = ?",
      [productId]
    );

    if (product.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "Product not found",
      });
    }

    await db.execute(
      "INSERT INTO reviews (user_id, product_id, rating, comment) VALUES (?, ?, ?, ?)",
      [userId, productId, rating, comment]
    );

    const [avgResult] = await db.execute(
      "SELECT AVG(rating) AS avg_rating FROM reviews WHERE product_id = ?",
      [productId]
    );

    const avgRating = Number(avgResult[0].avg_rating).toFixed(1);
    // console.log(avgRating);

    await db.execute("UPDATE products SET rating = ? WHERE id = ?", [
      avgRating,
      productId,
    ]);

    successResponse({
      res,
      statusCode: 201,
      message: "Review added successfully",
      data: {
        userId,
        productId,
        rating,
        comment,
      }
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
