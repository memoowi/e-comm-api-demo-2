import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const addCategory = async (req, res) => {
  const { name, description } = req.body;

  if (!name || !description) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  if (!req.file) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "Image file is required",
    });
  }

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
    const imgUrl = `${req.file.destination}/${req.file.filename}`.replaceAll('\\', '/');

    const slug = name
      .toLowerCase()
      .replace(/\s+/g, "-")
      .replace(/&/g, "and")
      .replace(/[^\w-]/g, "");
    const [result] = await db.execute(
      "INSERT INTO categories (name, description, slug, img_url) VALUES (?, ?, ?, ?)",
      [name, description, slug, imgUrl]
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
      "SELECT * FROM categories"
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

export const addSlugtoAllCategories = async (req, res) => {
  try {
    const [rows] = await db.execute("SELECT id, name FROM categories");
    for (const category of rows) {
      const slug = category.name
        .toLowerCase()
        .replace(/\s+/g, "-")
        .replace(/&/g, "and")
        .replace(/[^\w-]/g, "");
      await db.execute("UPDATE categories SET slug = ? WHERE id = ?", [
        slug,
        category.id,
      ]);
    }
    successResponse({
      res,
      statusCode: 200,
      message: "Success adding slug to categories",
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};

export const fixAllCategoryImages = async (req, res) => {
  try {
    const [categories] = await db.execute("SELECT id, img_url FROM categories");

    for (const category of categories) {
      if (category.img_url) {
        try {
          const imgUrl = category.img_url.replaceAll("\\", "/");
          await db.execute("UPDATE categories SET img_url = ? WHERE id = ?", [
            imgUrl,
            category.id,
          ]);
          console.log(`Updated category ${category.id}`);
        } catch (error) {
          console.error(`Error updating category ${category.id}:`, error);
        }
      }
    }

    successResponse({
      res,
      statusCode: 200,
      message: "Success fixing category images",
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};