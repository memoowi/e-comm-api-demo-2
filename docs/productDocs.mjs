export default {
  "/product": {
    get: {
      summary: "Get all products",
      description: "Get all products.",
      tags: ["Product"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "API Key for authentication",
          schema: { type: "string", example: "your-api-key" },
        },
        {
          in: "query",
          name: "page",
          required: false,
          description: "Page number for pagination",
          schema: { type: "number", example: 1 },
        },
        {
          in: "query",
          name: "limit",
          required: false,
          description: "Number of items per page",
          schema: { type: "number", example: 10 },
        },
        {
          in: "query",
          name: "sortBy",
          required: false,
          description: "Field to sort by",
          schema: {
            type: "string",
            example: "price",
            enum: ["name", "price", "stock", "created_at"],
          },
        },
        {
          in: "query",
          name: "order",
          required: false,
          description: "Sort order (asc or desc)",
          schema: { type: "string", example: "asc", enum: ["asc", "desc"] },
        },
        {
          in: "query",
          name: "q",
          required: false,
          description: "Search query",
          schema: { type: "string", example: "product name or description" },
        },
        {
          in: "query",
          name: "category",
          required: false,
          description: "Filter by category",
          schema: { type: "string", example: "category-slug" },
        },
      ],
      responses: {
        200: { description: "List of products" },
        400: { description: "Validation error" },
        403: { description: "Invalid API Key" },
        500: { description: "Internal Server Error" },
      },
    },
  },
  "/product/{slug}": {
    get: {
      summary: "Get product details",
      description: "Get details of a specific product by slug.",
      tags: ["Product"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "API Key for authentication",
          schema: { type: "string", example: "your-api-key" },
        },
        {
          in: "path",
          name: "slug",
          required: true,
          description: "Slug of the product",
          schema: { type: "string", example: "product-slug" },
        },
      ],
      responses: {
        200: { description: "Product details" },
        403: { description: "Invalid API Key" },
        404: { description: "Product not found" },
        500: { description: "Internal Server Error" },
      },
    },
  },
};
