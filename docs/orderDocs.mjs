export default {
    "/order": {
        post: {
            summary: "Create a new order",
            description: "Create a new order.",
            tags: ["Order"],
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
                            required: ["addressId", "items"],
                            properties: {
                                addressId: { type: "number", example: 1 },
                                items: {
                                    type: "array",
                                    items: {
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
                    },
                },
            },
            responses: {
                201: { description: "Order created" },
                400: { description: "Validation error" },
                403: { description: "Invalid API Key" },
                404: { description: "Address not found" },
                500: { description: "Internal Server Error" },
            },
        }
    }
}