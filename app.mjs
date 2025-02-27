import dotenv from "dotenv";
import express from "express";
import db from "./config/db.mjs";
import { adminKeyAuth } from "./middlewares/adminMiddleware.mjs";
import { apiKeyAuth, authenticate } from "./middlewares/authMiddleware.mjs";
import publicRoutes from "./routes/publicRoutes.mjs";
import adminRoutes from "./routes/adminRoutes.mjs";
import authenticateRoutes from "./routes/authenticateRoutes.mjs";
import { logMiddleware, logStream } from "./middlewares/logMiddleware.mjs";
import cors from "cors";
import swaggerUi from "swagger-ui-express";
import { swaggerDocs, swaggerUiOptions } from "./docs/swaggerDef.mjs";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocs, swaggerUiOptions));
console.log(`API Docs available at http://localhost:${PORT}/docs`);


app.use(logMiddleware);
app.use(cors());

app.use("/uploads", express.static("uploads"));


app.use(express.json());

app.use("/api/admin", adminKeyAuth, adminRoutes);
app.use("/api", apiKeyAuth, publicRoutes);
app.use("/api", apiKeyAuth, authenticate, authenticateRoutes);

(async () => {
  try {
    await db.getConnection();
    console.log("Connected to MySQL database.");
  } catch (err) {
    console.error("Database connection failed:", err);
  }
})();


app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

process.on("beforeExit", () => {
  logStream.end();
});
