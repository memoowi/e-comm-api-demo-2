import { Router } from "express";
import { register, login } from "../controllers/authController.mjs";
import { getAllCategories } from "../controllers/categoryController.mjs";

const router = Router();

router.post("/register", register);
router.post("/login", login);

router.get("/category", getAllCategories);

export default router;
