export default {
    "/category": {
        get: {
            summary: "Get all categories",
            description: "Get all categories.",
            tags: ["Category"],
            parameters: [
                {
                    in: "header",
                    name: "x-api-key",
                    required: true,
                    description: "API Key for authentication",
                    schema: { type: "string", example: "your-api-key" },
                },
            ],
            responses: {
                200: { description: "List of categories" },
                403: { description: "Invalid API Key" },
                500: { description: "Internal Server Error" },
            },
        }
    }
}