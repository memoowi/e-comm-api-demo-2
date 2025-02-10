import { Router } from "express";
import { getUser } from "../controllers/authController.mjs";
import { addReview } from "../controllers/reviewController.mjs";
import { addCart, deleteCart, getCart } from "../controllers/cartController.mjs";
import { addAddress, deleteAddress, getAddresses, updateAddress } from "../controllers/addressController.mjs";

const router = Router();

router.get("/user", getUser);
router.post("/review", addReview);
router.post("/cart", addCart);
router.get("/cart", getCart);
router.delete("/cart", deleteCart);
router.post("/address", addAddress);
router.get("/address", getAddresses);
router.delete("/address", deleteAddress);
router.patch("/address", updateAddress);

export default router;