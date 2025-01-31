import { Router } from "express";
import { addCategory, addSlugtoAllCategories } from "../controllers/categoryController.mjs";
import { upload } from "../middlewares/fileUpload.mjs";
import { uploadErrorHandler } from "../handler/responseHandler.mjs";
import { addProduct } from "../controllers/productController.mjs";

const router = Router();

router.post("/category", upload.single("image"), addCategory, uploadErrorHandler);
router.post("/category/slug", addSlugtoAllCategories);
router.post("/product", upload.array("images"), addProduct, uploadErrorHandler);

export default router;