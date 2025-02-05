import { Router } from "express";
import { getUser } from "../controllers/authController.mjs";
import { addReview } from "../controllers/reviewController.mjs";

const router = Router();

router.get("/user", getUser);
router.post("/review", addReview);

export default router;