import { Router } from "express";
import { getUser } from "../controllers/authController.mjs";
import { addReview } from "../controllers/reviewController.mjs";
import { addCart, deleteCart, getCart } from "../controllers/cartController.mjs";

const router = Router();

router.get("/user", getUser);
router.post("/review", addReview);
router.post("/cart", addCart);
router.get("/cart", getCart);
router.delete("/cart", deleteCart);

export default router;