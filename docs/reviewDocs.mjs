export default {
  "/review": {
    post: {
      summary: "Add a review",
      description: "Add a review for a product.",
      tags: ["Review"],
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
              required: ["productId", "rating", "comment"],
              properties: {
                productId: { type: "integer", example: 12 },
                rating: { type: "integer", example: 4, minimum: 1, maximum: 5 },
                comment: { type: "string", example: "Great product!" },
              },
            },
          },
        },
      },
      responses: {
        201: { description: "Review added successfully" },
        400: { description: "Invalid jwt token or Invalid request data" },
        401: { description: "Unauthorized" },
        404: { description: "Product not found" },
        500: { description: "Internal Server Error" },
      },
    },
  },
};
