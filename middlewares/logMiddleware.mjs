import path from "path";
import fs from "fs";
import { errorResponse } from "../handler/responseHandler.mjs";
import { blockedIps } from "../config/blockedIps.mjs";

// Log file setup
const logDirectory = path.join("logs");
if (!fs.existsSync(logDirectory)) {
  fs.mkdirSync(logDirectory);
}
const logFilePath = path.join(logDirectory, "requests.log");
export const logStream = fs.createWriteStream(logFilePath, { flags: "a" }); // 'a' for append

// Middleware to log IP addresses
export const logMiddleware = (req, res, next) => {
  const ip = req.headers["x-forwarded-for"] || req.socket.remoteAddress;
  const timestamp = new Date().toISOString();

  // Capture the response status code after the response is sent
  res.on("finish", () => {
    const statusCode = res.statusCode;
    const logMessage = `${timestamp} - ${req.method} ${req.originalUrl} - IP: ${ip} - Status: ${statusCode} - ${res.statusMessage} - User-Agent: ${req.headers["user-agent"]}\n`;
    console.log(logMessage);
    logStream.write(logMessage);
  });

  const blockedList = blockedIps;

  if (blockedList.includes(ip)) {
    return errorResponse({ res, statusCode: 403, message: "IP is blocked" });
  }

  next();
};
