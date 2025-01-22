import dotenv from "dotenv";
import express from "express";
import authRoutes from "./routes/authRoutes.mjs";
import db from "./config/db.mjs";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(express.json());

// Routes
app.use("/api", authRoutes);

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
