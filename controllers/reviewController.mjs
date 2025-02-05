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

    const [product] = await db.execute("SELECT id FROM products WHERE id = ?", [
      productId,
    ]);

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
      },
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};

// ADMIN
export const generateFakeReviewsForAllProducts = async (req, res) => {
  try {
    const { count = 10 } = req.body;

    const [products] = await db.execute("SELECT id FROM products");

    if (products.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "No products found",
      });
    }

    const [users] = await db.execute("SELECT id FROM users");

    if (users.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "No users found",
      });
    }
    // console.log(users.length);
    const fakeReviews = [];

    const sampleReviews = [
      "Great product! Highly recommended.",
      "Not bad, but could be better.",
      "Amazing quality for the price!",
      "Would buy again.",
      "Decent product, but delivery was slow.",
      "Exceeded my expectations!",
      "The build quality is impressive.",
      "Good value for money.",
      "I love this! Works perfectly.",
      "Not worth the hype.",
      "Very satisfied with my purchase.",
      "It's okay, nothing special.",
    ];

    for (const product of products) {
      for (let i = 0; i < count; i++) {
        const userId = users[Math.floor(Math.random() * users.length)].id;
        const rating = Math.floor(Math.random() * 3) + 3; // Random rating (3 to 5)
        const comment =
          sampleReviews[Math.floor(Math.random() * sampleReviews.length)]; // Random review
        const createdAt = new Date(
          Date.now() - Math.random() * 1000000000
        ).toISOString(); // Random past date

        fakeReviews.push([userId, product.id, rating, comment, createdAt]);
      }
    }
    // console.log(fakeReviews);

    await db.query(
      "INSERT INTO reviews ( user_id, product_id, rating, comment, created_at) VALUES ?",
      [fakeReviews]
    );

    for (const product of products) {
      const [avgResult] = await db.execute(
        "SELECT AVG(rating) AS avg_rating FROM reviews WHERE product_id = ?",
        [product.id]
      );
      const avgRating = Number(avgResult[0].avg_rating).toFixed(1);
      await db.execute("UPDATE products SET rating = ? WHERE id = ?", [
        avgRating,
        product.id,
      ]);
    }

    successResponse({
      res,
      statusCode: 201,
      message: `Successfully added ${count} fake reviews for each product (${products.length} products)`,
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
