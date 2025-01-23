import { Router } from "express";
import { getUser } from "../controllers/authController.mjs";

const router = Router();

router.get("/user", getUser);

export default router;