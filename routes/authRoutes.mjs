import { Router } from "express";
import { register, login, getUser } from "../controllers/authController.mjs";
import { apiKeyAuth, authenticate } from "../middlewares/authMiddleware.mjs";

const router = Router();

router.post("/register", apiKeyAuth, register);
router.post("/login", apiKeyAuth, login);
router.get("/user", apiKeyAuth, authenticate, getUser);
// router.get("/test", (req, res) => {
//     const ipaddress = req.ip;
//   res.status(200).json({ ipaddress });
// });

export default router;
