import { Router } from "express";
import { addCategory } from "../controllers/categoryController.mjs";

const router = Router();

router.post("/category", addCategory);

export default router;