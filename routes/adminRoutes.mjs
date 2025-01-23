import { Router } from "express";
import { addCategory } from "../controllers/categoryController.mjs";
import { upload } from "../middlewares/fileUpload.mjs";
import { uploadErrorHandler } from "../handler/responseHandler.mjs";

const router = Router();

router.post("/category", upload.single("image"), addCategory, uploadErrorHandler);

export default router;