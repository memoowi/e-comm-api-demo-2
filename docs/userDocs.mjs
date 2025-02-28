export default {
  "/user": {
    get: {
      summary: "Get user details",
      description: "Get the details of the currently authenticated user.",
      tags: ["User"],
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
        200: { description: "User details" },
        400: { description: "Invalid jwt token" },
        401: { description: "Unauthorized" },
        404: { description: "User not found" },
        500: { description: "Internal Server Error" },
      },
    },
    patch: {
      summary: "Update user name and email",
      description:
        "Update the name and email of the currently authenticated user.",
      tags: ["User"],
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
              properties: {
                name: { type: "string", example: "Updated Name" },
                email: { type: "string", example: "updated@examplecom" },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "User details updated" },
        400: { description: "Invalid jwt token" },
        401: { description: "Unauthorized" },
        404: { description: "User not found" },
        409: { description: "Email already exists" },
        500: { description: "Internal Server Error" },
      },
    },
  },

  "/user/password": {
    patch: {
      summary: "Update user password",
      description: "Update the password of the currently authenticated user.",
      tags: ["User"],
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
              required: ["oldPassword", "newPassword"],
              properties: {
                oldPassword: { type: "string", example: "oldpassword" },
                newPassword: { type: "string", example: "newpassword" },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "Password updated" },
        400: { description: "Invalid jwt token or validation error" },
        401: { description: "Unauthorized or invalid password" },
        404: { description: "User not found" },
        500: { description: "Internal Server Error" },
      },
    },
  },

  "/user/profile-photo": {
    post: {
      summary: "Upload profile photo",
      description:
        "Upload a profile photo for the currently authenticated user.",
      tags: ["User"],
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
          "multipart/form-data": {
            schema: {
              type: "object",
              required: ["photo"],
              properties: {
                photo: { type: "string", format: "binary" },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "Profile photo uploaded" },
        400: { description: "Invalid jwt token or validation error" },
        401: { description: "Unauthorized" },
        404: { description: "User not found" },
        500: { description: "Internal Server Error" },
      },
    },
  },
};
