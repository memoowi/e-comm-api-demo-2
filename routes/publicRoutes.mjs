import { Router } from "express";
import { register, login } from "../controllers/authController.mjs";
import { getAllCategories } from "../controllers/categoryController.mjs";

const router = Router();

router.post("/register", register);
router.post("/login", login);

router.get("/category", getAllCategories);
// router.get("/test", (req, res) => {
//     const ipaddress = req.ip;
//   res.status(200).json({ ipaddress });
// });

export default router;
