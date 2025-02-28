import multer from "multer";

export const successResponse = ({
  res,
  statusCode = 200,
  status = "OK",
  message,
  data,
  metadata,
}) => {
  return res.status(statusCode).json({
    status: status,
    message: message,
    data,
    metadata,
  });
};

export const errorResponse = ({
  res,
  statusCode = 500,
  status = "ERROR",
  message,
  data,
}) => {
  return res.status(statusCode).json({
    status: status,
    message: message,
    data: data,
  });
};

export const uploadErrorHandler = (err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    if (err.code === 'LIMIT_FILE_SIZE') {
      return res.status(400).json({
        status: "ERROR",
        message: err.message,
      });
    }
    return res.status(400).json({
      status: "ERROR",
      message: `Multer error: ${err.message}`,
    });
  } else if (err) {
    return res.status(400).json({
      status: "ERROR",
      message: err.message || 'File upload error.',
    });
  }
  next();
};
