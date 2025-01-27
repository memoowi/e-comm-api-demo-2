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

  // Check if a file is uploaded
  if (!req.file) {
    return errorResponse(res, "Image file is required", 400);
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
    // Get the image URL
    // const baseUrl = req.protocol + "://" + req.get("host");
    // const imgUrl = `${baseUrl}/${req.file.destination}/${req.file.filename}`;
    const imgUrl = `${req.file.destination}/${req.file.filename}`;

    // INSERT THE NEW CATEGORY
    const [result] = await db.execute(
      "INSERT INTO categories (name, description, img_url) VALUES (?, ?, ?)",
      [name, description, imgUrl]
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
    errorResponse({ res, statusCode: 500, message: error.message });
  }
};

export const getAllCategories = async (req, res) => {
  try {
    const [rows] = await db.execute(
      "SELECT name, description, img_url FROM categories"
    );
    successResponse({
      res,
      statusCode: 200,
      message: "Success fetching categories data",
      data: rows,
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
