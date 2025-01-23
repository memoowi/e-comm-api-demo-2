import dotenv from "dotenv";
import express from "express";
import db from "./config/db.mjs";
import { adminKeyAuth } from "./middlewares/adminMiddleware.mjs";
import { apiKeyAuth, authenticate } from "./middlewares/authMiddleware.mjs";
import publicRoutes from "./routes/publicRoutes.mjs";
import adminRoutes from "./routes/adminRoutes.mjs";
import authenticateRoutes from "./routes/authenticateRoutes.mjs";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Serve static files from the uploads directory
app.use("/uploads", express.static("uploads"));

// Middleware
app.use(express.json());

// Routes
app.use("/api", apiKeyAuth, publicRoutes);
app.use("/api", apiKeyAuth, authenticate, authenticateRoutes);
app.use("/api/admin", adminKeyAuth, adminRoutes);

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
