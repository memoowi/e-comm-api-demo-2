import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const addCategory = async (req, res) => {
  const { name, description } = req.body;

  // VALIDATE INPUT
  if (!name || !description) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  // CHECK IF CATEGORY EXIST
  const [existingCategory] = await db.execute(
    "SELECT * FROM categories WHERE name = ?",
    [name]
  );
  if (existingCategory.length > 0) {
    return errorResponse({
      res,
      statusCode: 409,
      message: "Category already exists",
    });
  }

  try {
    // INSERT THE NEW CATEGORY
    const [result] = await db.execute(
      "INSERT INTO categories (name, description) VALUES (?, ?)",
      [name, description]
    );
    const newCategory = await db.execute(
      "SELECT * FROM categories WHERE id = ?",
      [result.insertId]
    );

    successResponse({
      res,
      statusCode: 201,
      message: "Category added successfully",
      data: newCategory[0],
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
