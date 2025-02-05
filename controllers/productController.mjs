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
    const slug = name.toLowerCase().replace(/\s+/g, "-").replace(/&/g, 'and').replace(/[^\w-]/g, "");
    const [result] = await db.execute(
      "INSERT INTO products (name, slug, description, variant, price, stock, category_id, img_urls) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [
        name,
        slug,
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

export const getAllProducts = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 10,
      sortBy = "name",
      order = "asc",
      q = "",
      category = "",
    } = req.query;

    const validSortColumns = ["name", "price", "stock", "created_at"];
    const validOrder = ["asc", "desc"];

    if (!validSortColumns.includes(sortBy)) {
      return errorResponse({
        res,
        statusCode: 400,
        message: `Invalid sortBy value. Valid values: ${validSortColumns.join(
          ", "
        )}`,
      });
    }

    if (!validOrder.includes(order.toLowerCase())) {
      return errorResponse({
        res,
        statusCode: 400,
        message: `Invalid order value. Valid values: asc, desc`,
      });
    }

    const offset = (page - 1) * limit;
    const searchQuery = `%${q}%`;

    let baseQuery = `
      SELECT p.*, c.name AS category_name 
      FROM products p 
      LEFT JOIN categories c ON p.category_id = c.id
      WHERE (p.name LIKE ? OR p.description LIKE ?)`;

    let queryParams = [searchQuery, searchQuery];

    if (category) {
      baseQuery += " AND c.slug = ?";
      queryParams.push(category);
    }

    const countQuery = `SELECT COUNT(*) AS total FROM (${baseQuery}) AS filtered_products`;
    const paginatedQuery = `
      ${baseQuery}
      ORDER BY ${sortBy} ${order.toUpperCase()} 
      LIMIT ? OFFSET ?`;

    queryParams.push(parseInt(limit), parseInt(offset));

    const [totalCountResult] = await db.execute(countQuery, queryParams.slice(0, -2));
    const totalCount = totalCountResult[0].total;

    const [rows] = await db.execute(paginatedQuery, queryParams);

    const [categoryData] = await db.execute(`SELECT * FROM categories WHERE slug = ?`, [category]);

    successResponse({
      res,
      statusCode: 200,
      message: "Success fetching products data",
      data: rows.map((product) => ({
        ...product,
        variant: JSON.parse(product.variant),
        img_urls: JSON.parse(product.img_urls),
      })),
      metadata: {
        currentPage: parseInt(page),
        totalPages: Math.ceil(totalCount / limit),
        totalItems: totalCount,
        itemsPerPage: parseInt(limit),
        category: categoryData[0],
      },
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};



export const addSlugintoAllProducts = async (req, res) => {
  try {
    const [rows] = await db.execute(
      "SELECT id, name FROM products"
    );
    for (const product of rows) {
      const slug = product.name.toLowerCase().replace(/\s+/g, "-").replace(/&/g, 'and').replace(/[^\w-]/g, "");
      await db.execute(
        "UPDATE products SET slug = ? WHERE id = ?",
        [slug, product.id]
      );
    }
    successResponse({
      res,
      statusCode: 200,
      message: "Success adding slug to products",
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
}