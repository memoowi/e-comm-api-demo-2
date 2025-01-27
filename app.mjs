import dotenv from "dotenv";
import express from "express";
import db from "./config/db.mjs";
import { adminKeyAuth } from "./middlewares/adminMiddleware.mjs";
import { apiKeyAuth, authenticate } from "./middlewares/authMiddleware.mjs";
import publicRoutes from "./routes/publicRoutes.mjs";
import adminRoutes from "./routes/adminRoutes.mjs";
import authenticateRoutes from "./routes/authenticateRoutes.mjs";
import { logMiddleware, logStream } from "./middlewares/logMiddleware.mjs";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware to log IP addresses
app.use(logMiddleware);

// Serve static files from the uploads directory
app.use("/uploads", express.static("uploads"));

// Middleware
app.use(express.json());

// Routes with Middlewares
app.use("/api/admin", adminKeyAuth, adminRoutes);
app.use("/api", apiKeyAuth, publicRoutes);
app.use("/api", apiKeyAuth, authenticate, authenticateRoutes);

// Check DB connection
(async () => {
  try {
    await db.getConnection();
    console.log("Connected to MySQL database.");
  } catch (err) {
    console.error("Database connection failed:", err);
  }
})();

// Start Server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

process.on("beforeExit", () => {
  // Close the log stream on exit
  logStream.end();
});
