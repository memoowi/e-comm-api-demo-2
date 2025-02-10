export default {
  "/register": {
    post: {
      summary: "User registration",
      description: "Register a new user with email and password.",
      tags: ["Authentication"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "API Key for authentication",
          schema: { type: "string", example: "your-api-key" },
        },
      ],
      requestBody: {
        required: true,
        content: {
          "application/json": {
            schema: {
              type: "object",
              required: ["name", "email", "password"],
              properties: {
                name: { type: "string", example: "New User" },
                email: { type: "string", example: "newuser@example.com" },
                password: { type: "string", example: "securepassword" },
              },
            },
          },
        },
      },
      responses: {
        201: { description: "Successfully registered" },
        400: { description: "Validation error" },
        403: { description: "Invalid API Key" },
        409: { description: "Email already exists" },
        500: { description: "Server error" },
      },
    },
  },

  "/login": {
    post: {
      summary: "User login",
      description: "Log in with email and password.",
      tags: ["Authentication"],
      parameters: [
        {
          in: "header",
          name: "x-api-key",
          required: true,
          description: "API Key for authentication",
          schema: { type: "string", example: "your-api-key" },
        },
      ],
      requestBody: {
        required: true,
        content: {
          "application/json": {
            schema: {
              type: "object",
              required: ["email", "password"],
              properties: {
                email: { type: "string", example: "newuser@example.com" },
                password: { type: "string", example: "securepassword" },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "Login successful" },
        400: { description: "Validation error" },
        401: { description: "Incorrect password" },
        403: { description: "Invalid API Key" },
        404: { description: "User not found" },
        500: { description: "Server error" },
      },
    },
  },
};
