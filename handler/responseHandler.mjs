export const successResponse = ({
  res,
  statusCode = 200,
  status = "OK",
  message,
  data,
}) => {
  return res.status(statusCode).json({
    status: status,
    message: message,
    data,
  });
};

export const errorResponse = ({
  res,
  statusCode = 500,
  status = "ERROR",
  message,
}) => {
  return res.status(statusCode).json({
    status: status,
    message: message,
    data: null,
  });
};
