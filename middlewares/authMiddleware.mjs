import jwt from "jsonwebtoken";
import { errorResponse } from "../handler/responseHandler.mjs";

export const authenticate = (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) {
    return res.status(401).json({ error: "Access Denied" });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    errorResponse({ res, statusCode: 400, message: err.message });
  }
};

export const apiKeyAuth = (req, res, next) => {
  const apiKey = req.headers["x-api-key"];
  if (apiKey !== process.env.API_KEY) {
    return errorResponse({ res, statusCode: 403, message: "Invalid API Key" });
  }
  next();
};
