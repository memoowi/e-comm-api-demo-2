import { Router } from "express";
import { register, login } from "../controllers/authController.mjs";
import { getAllCategories } from "../controllers/categoryController.mjs";
import { getAllProducts, getProductDetails } from "../controllers/productController.mjs";

const router = Router();

router.post("/register", register);
router.post("/login", login);

router.get("/category", getAllCategories);

router.get("/product", getAllProducts);
router.get("/product/:slug", getProductDetails);

export default router;