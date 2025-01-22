import { errorResponse } from "../handler/responseHandler.mjs";

export const adminKeyAuth = (req, res, next) => {
  const adminKey = req.headers["x-api-key"];
  if (adminKey !== process.env.ADMIN_API_KEY) {
    return errorResponse({ res, statusCode: 403, message: "Invalid Admin API Key" });
  }
  next();
};
