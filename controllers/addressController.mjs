import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const addAddress = async (req, res) => {
  const userId = req.user.id;
  const {
    address,
    subdistrict,
    district,
    regency,
    province,
    postalCode,
    phone,
  } = req.body;

  if (
    !address ||
    !subdistrict ||
    !district ||
    !regency ||
    !province ||
    !postalCode ||
    !phone
  ) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  try {
    const [result] = await db.execute(
      "INSERT INTO addresses (user_id, address, subdistrict, district, regency, province, postal_code, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [
        userId,
        address,
        subdistrict,
        district,
        regency,
        province,
        postalCode,
        phone,
      ]
    );

    successResponse({
      res,
      statusCode: 201,
      message: "Address added successfully",
      //   data: result,
    });
  } catch (error) {
    console.error(error);
    errorResponse({
      res,
      statusCode: 500,
      message: "Internal Server Error",
    });
  }
};

export const getAddresses = async (req, res) => {
  const userId = req.user.id;

  try {
    const [rows] = await db.execute(
      "SELECT * FROM addresses WHERE user_id = ?",
      [userId]
    );

    successResponse({
      res,
      statusCode: 200,
      message: "Success fetching addresses data",
      data: rows,
    });
  } catch (error) {
    console.error(error);
    errorResponse({
      res,
      statusCode: 500,
      message: "Internal Server Error",
    });
  }
};

export const deleteAddress = async (req, res) => {
  const userId = req.user.id;
  const { addressId } = req.body;

  try {
    const [result] = await db.execute(
      "DELETE FROM addresses WHERE user_id = ? AND id = ?",
      [userId, addressId]
    );

    successResponse({
      res,
      statusCode: 200,
      message: "Address deleted successfully",
      //   data: result,
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};

export const updateAddress = async (req, res) => {
  const userId = req.user.id;
  const {
    addressId,
    address,
    subdistrict,
    district,
    regency,
    province,
    postalCode,
    phone,
  } = req.body;

  if (!addressId) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "Address ID is required",
    });
  }

  try {
    const [existingAddress] = await db.execute(
      "SELECT * FROM addresses WHERE user_id = ? AND id = ?",
      [userId, addressId]
    );
    if (existingAddress.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "Address not found",
      });
    }

    const updateFields = {};
    if (address) updateFields.address = address;
    if (subdistrict) updateFields.subdistrict = subdistrict;
    if (district) updateFields.district = district;
    if (regency) updateFields.regency = regency;
    if (province) updateFields.province = province;
    if (postalCode) updateFields.postal_code = postalCode;
    if (phone) updateFields.phone = phone;

    console.log(updateFields);
    const baseQuery = "UPDATE addresses SET ";
    const updateQuery = Object.keys(updateFields)
      .map((key) => `${key} = ?`)
      .join(", ");
    const values = Object.values(updateFields);
    const query = `${baseQuery} ${updateQuery} WHERE user_id = ? AND id = ?`;
    const [result] = await db.execute(query, [...values, userId, addressId]);

    successResponse({
      res,
      statusCode: 200,
      message: "Address updated successfully",
      //   data: result,
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
