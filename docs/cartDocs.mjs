export default {
  "/cart": {
    get: {
      summary: "Get cart details",
      description:
        "Get the details of the currently authenticated user's cart.",
      tags: ["Cart"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "API Key for authentication",
          schema: { type: "string", example: "your-api-key" },
        },
        {
          in: "header",
          name: "Authorization",
          required: true,
          description: "JWT token for authentication",
          schema: { type: "string", example: "Bearer your-jwt-token" },
        },
      ],
      responses: {
        200: { description: "Cart list details" },
        400: { description: "Invalid jwt token" },
        401: { description: "Unauthorized" },
        500: { description: "Internal Server Error" },
      },
    },
    post: {
      summary: "Add or Update product to cart",
      description:
        "Add a product or update quantity to the currently authenticated user's cart.",
      tags: ["Cart"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "API Key for authentication",
          schema: { type: "string", example: "your-api-key" },
        },
        {
          in: "header",
          name: "Authorization",
          required: true,
          description: "JWT token for authentication",
          schema: { type: "string", example: "Bearer your-jwt-token" },
        },
      ],
      requestBody: {
        required: true,
        content: {
          "application/json": {
            schema: {
              type: "object",
              required: ["productId", "quantity"],
              properties: {
                productId: { type: "number", example: 1 },
                quantity: { type: "number", example: 1 },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "Product updated in cart" },
        201: { description: "Product added to cart" },
        400: { description: "Invalid jwt token or validation error" },
        401: { description: "Unauthorized" },
        404: { description: "User not found" },
        500: { description: "Internal Server Error" },
      },
    },
    delete: {
      summary: "Delete product from cart",
      description:
        "Delete a product from the currently authenticated user's cart.",
      tags: ["Cart"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "API Key for authentication",
          schema: { type: "string", example: "your-api-key" },
        },
        {
          in: "header",
          name: "Authorization",
          required: true,
          description: "JWT token for authentication",
          schema: { type: "string", example: "Bearer your-jwt-token" },
        },
      ],
      requestBody: {
        required: true,
        content: {
          "application/json": {
            schema: {
              type: "object",
              required: ["productId"],
              properties: {
                productId: { type: "number", example: 1 },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "Product deleted from cart" },
        400: { description: "Invalid jwt token or validation error" },
        401: { description: "Unauthorized" },
        500: { description: "Internal Server Error" },
      },
    },
  },
};
