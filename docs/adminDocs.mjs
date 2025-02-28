export default {
  "/admin/category": {
    post: {
      summary: "Add a new category",
      description: "Add a new category.",
      tags: ["Admin"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "ADMIN API Key for authentication",
          schema: { type: "string", example: "admin-api-key" },
        },
      ],
      requestBody: {
        required: true,
        content: {
          "multipart/form-data": {
            schema: {
              type: "object",
              required: ["name", "description", "image"],
              properties: {
                name: {
                  type: "string",
                  example: "Category Name",
                },
                description: {
                  type: "string",
                  example: "Category Description",
                },
                image: {
                  type: "string",
                  format: "binary",
                },
              },
            },
          },
        },
      },
      responses: {
        201: { description: "Category created successfully" },
        400: { description: "Validation error" },
        403: { description: "Invalid Admin API Key" },
        409: { description: "Category already exists" },
        500: { description: "Internal Server Error" },
      },
    },
  },

  "/admin/product": {
    post: {
      summary: "Add a new product",
      description: "Add a new product.",
      tags: ["Admin"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "ADMIN API Key for authentication",
          schema: { type: "string", example: "admin-api-key" },
        },
      ],
      requestBody: {
        required: true,
        content: {
          "multipart/form-data": {
            schema: {
              type: "object",
              required: [
                "name",
                "description",
                "price",
                "stock",
                "categoryId",
                "images",
              ],
              properties: {
                name: {
                  type: "string",
                  example: "Product Name",
                },
                description: {
                  type: "string",
                  example: "Product Description",
                },
                variant: {
                  type: "array",
                  example: ["Variant 1", "Variant 2"],
                },
                price: {
                  type: "number",
                  example: 120000,
                },
                stock: {
                  type: "number",
                  example: 10,
                },
                categoryId: {
                  type: "number",
                  example: 1,
                },
                images: {
                  type: "array",
                  items: {
                    type: "string",
                    format: "binary",
                  },
                },
              },
            },
          },
        },
      },
      responses: {
        201: { description: "Product created successfully" },
        400: { description: "Validation error" },
        403: { description: "Invalid Admin API Key" },
        409: { description: "Product already exists" },
        500: { description: "Internal Server Error" },
      },
    },
  },

  "/admin/category/slug": {
    post: {
      summary: "GENERATE slug to all categories",
      description: "Generate slug to all categories.",
      tags: ["Admin"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "ADMIN API Key for authentication",
          schema: { type: "string", example: "admin-api-key" },
        },
      ],
      responses: {
        200: { description: "Slug added to all categories" },
        403: { description: "Invalid Admin API Key" },
        500: { description: "Internal Server Error" },
      },
    },
  },

  "/admin/product/slug": {
    post: {
      summary: "GENERATE slug to all products",
      description: "Generate slug to all products.",
      tags: ["Admin"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "ADMIN API Key for authentication",
          schema: { type: "string", example: "admin-api-key" },
        },
      ],
      responses: {
        200: { description: "Slug added to all products" },
        403: { description: "Invalid Admin API Key" },
        500: { description: "Internal Server Error" },
      },
    },
  },

  "/admin/review": {
    post: {
      summary: "GENERATE fake reviews for all products",
      description: "Generate n count of fake reviews for all products.",
      tags: ["Admin"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "ADMIN API Key for authentication",
          schema: { type: "string", example: "admin-api-key" },
        },
      ],
      requestBody: {
        required: false,
        content: {
          "application/json": {
            schema: {
              type: "object",
              properties: {
                count: {
                  type: "number",
                  example: 10,
                },
              },
            },
          },
        },
      },
      responses: {
        201: { description: "Fake reviews added to all products" },
        403: { description: "Invalid Admin API Key" },
        404: { description: "Products or Users not found" },
        500: { description: "Internal Server Error" },
      },
    },
  },
};
