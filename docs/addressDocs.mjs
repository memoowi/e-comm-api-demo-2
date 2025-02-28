export default {
  "/address": {
    post: {
      summary: "Add address",
      description: "Add a new address for the currently authenticated user.",
      tags: ["Address"],
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
              required: [
                "address",
                "subdistrict",
                "district",
                "regency",
                "province",
                "postalCode",
                "phone",
              ],
              properties: {
                address: { type: "string", example: "Jl. Raya No. 1" },
                subdistrict: { type: "string", example: "Keluarahan/Desa" },
                district: { type: "string", example: "Kecamatan" },
                regency: { type: "string", example: "Kabupaten/Kota" },
                province: { type: "string", example: "Province" },
                postalCode: { type: "string", example: "12345" },
                phone: { type: "string", example: "08123456789" },
              },
            },
          },
        },
      },
      responses: {
        201: { description: "Address added successfully" },
        400: { description: "Invalid jwt token or missing required fields" },
        401: { description: "Unauthorized" },
        500: { description: "Internal Server Error" },
      },
    },
    get: {
      summary: "Get all addresses",
      description: "Get all addresses for the currently authenticated user.",
      tags: ["Address"],
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
        200: { description: "List of addresses" },
        400: { description: "Invalid jwt token" },
        401: { description: "Unauthorized" },
        500: { description: "Internal Server Error" },
      },
    },
    patch: {
      summary: "Update address",
      description: "Update an address for the currently authenticated user.",
      tags: ["Address"],
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
              required: ["addressId"],
              properties: {
                addressId: { type: "number", example: 1 },
                address: { type: "string", example: "Updated Address" },
                subdistrict: { type: "string", example: "Updated Subdistrict" },
                district: { type: "string", example: "Updated District" },
                regency: { type: "string", example: "Updated Regency" },
                province: { type: "string", example: "Updated Province" },
                postalCode: { type: "string", example: "Updated Postal Code" },
                phone: { type: "string", example: "Updated Phone" },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "Address updated successfully" },
        400: { description: "Invalid jwt token or missing required fields" },
        401: { description: "Unauthorized" },
        404: { description: "Address not found" },
        500: { description: "Internal Server Error" },
      },
    },
    delete: {
      summary: "Delete address",
      description: "Delete an address for the currently authenticated user.",
      tags: ["Address"],
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
              required: ["addressId"],
              properties: {
                addressId: { type: "number", example: 1 },
              },
            },
          },
        },
      },
      responses: {
        200: { description: "Address deleted successfully" },
        400: { description: "Invalid jwt token or missing required fields" },
        401: { description: "Unauthorized" },
        500: { description: "Internal Server Error" },
      },
    },
  },
};
