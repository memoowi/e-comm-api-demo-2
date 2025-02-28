import bcrypt from "bcrypt";
import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const updateNameEmail = async (req, res) => {
  const userId = req.user.id;
  const { name, email } = req.body;

  try {
    //optional update
    const updateFields = {};
    if (name) updateFields.name = name;
    if (email) updateFields.email = email;

    const [existingUser] = await db.execute(
      "SELECT * FROM users WHERE id = ?",
      [userId]
    );
    if (existingUser.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "User not found",
      });
    }

    if (email) {
      const [existingEmail] = await db.execute(
        "SELECT * FROM users WHERE email = ?",
        [email]
      );
      if (existingEmail.length > 0) {
        return errorResponse({
          res,
          statusCode: 409,
          message: "Email already exists",
        });
      }
    }

    const baseQuery = "UPDATE users SET ";
    const updateQuery = Object.keys(updateFields)
      .map((key) => `${key} = ?`)
      .join(", ");
    const values = Object.values(updateFields);
    const query = `${baseQuery} ${updateQuery} WHERE id = ?`;
    const [result] = await db.execute(query, [...values, userId]);

    successResponse({
      res,
      statusCode: 200,
      message: "User updated successfully",
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

export const updatePassword = async (req, res) => {
  const userId = req.user.id;
  const { oldPassword, newPassword } = req.body;

  try {
    const [existingUser] = await db.execute(
      "SELECT * FROM users WHERE id = ?",
      [userId]
    );
    if (existingUser.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "User not found",
      });
    }

    const validPassword = await bcrypt.compare(
      oldPassword,
      existingUser[0].password
    );
    if (!validPassword) {
      return errorResponse({
        res,
        statusCode: 401,
        message: "Incorrect Password",
      });
    }

    if (newPassword === oldPassword) {
      return errorResponse({
        res,
        statusCode: 400,
        message: "New password cannot be the same as the old password",
      });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);

    const [result] = await db.execute(
      "UPDATE users SET password = ? WHERE id = ?",
      [hashedPassword, userId]
    );

    successResponse({
      res,
      statusCode: 200,
      message: "Password updated successfully",
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

export const updateProfilePhoto = async (req, res) => {
  const userId = req.user.id;

  if (!req.file) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "photo is required",
    });
  }

  try {
    console.log(req.file.destination);
    const imgUrl = `${req.file.destination}/${req.file.filename}`.replaceAll('\\', '/');

    const [existingUser] = await db.execute(
      "SELECT * FROM users WHERE id = ?",
      [userId]
    );
    if (existingUser.length === 0) {
      return errorResponse({
        res,
        statusCode: 404,
        message: "User not found",
      });
    }

    const [result] = await db.execute(
      "UPDATE users SET profile_photo = ? WHERE id = ?",
      [imgUrl, userId]
    );

    successResponse({
      res,
      statusCode: 200,
      message: "Profile photo updated successfully",
      data: result,
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
