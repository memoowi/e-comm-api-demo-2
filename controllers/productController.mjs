import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const addProduct = async (req, res) => {
  const { name, description, variant, price, stock, categoryId } = req.body;

  if (!name || !description || !price || !stock || !categoryId) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  if (!req.files || req.files.length === 0) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "At least one image file is required",
    });
  }

  // Parse variants if provided
  let parsedVariant = [];
  if (variant) {
    try {
      parsedVariant = JSON.parse(variant);
      if (!Array.isArray(parsedVariant)) {
        throw new Error();
      }
    } catch {
      return errorResponse({
        res,
        statusCode: 400,
        message: "Invalid format for variants. Must be a JSON array.",
      });
    }
  }

  const [existingProduct] = await db.execute(
    "SELECT * FROM products WHERE name = ?",
    [name]
  );

  if (existingProduct.length > 0) {
    return errorResponse({
      res,
      statusCode: 409,
      message: "Product already exists",
    });
  }

  try {
    const imgUrls = req.files.map((file) => file.path);
    const [result] = await db.execute(
      "INSERT INTO products (name, description, variant, price, stock, category_id, img_urls) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [
        name,
        description,
        JSON.stringify(parsedVariant),
        price,
        stock,
        categoryId,
        JSON.stringify(imgUrls),
      ]
    );

    const [product] = await db.execute("SELECT * FROM products WHERE id = ?", [
      result.insertId,
    ]);
    const [category] = await db.execute(
      "SELECT name FROM categories WHERE id = ?",
      [categoryId]
    );

    product[0].category_name = category[0].name;
    successResponse({
      res,
      statusCode: 201,
      message: "Product added successfully",
      data: {
        ...product[0],
        variant: JSON.parse(product[0].variant),
        img_urls: JSON.parse(product[0].img_urls),
      },
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
