import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const register = async (req, res) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  try {
    const [existingUser] = await db.execute(
      "SELECT * FROM users WHERE email = ?",
      [email]
    );
    if (existingUser.length > 0) {
      return errorResponse({
        res,
        statusCode: 409,
        message: "Email is already registered",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await db.execute(
      "INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
      [name, email, hashedPassword]
    );

    const token = jwt.sign(
      { id: result.insertId, email, name },
      process.env.JWT_SECRET,
      { expiresIn: "8h" }
    );

    successResponse({
      res,
      statusCode: 201,
      message: "User Registered",
      data: { token },
    });
  } catch (err) {
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};

export const login = async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  try {
    const [rows] = await db.execute("SELECT * FROM users WHERE email = ?", [
      email,
    ]);
    if (rows.length === 0) {
      return errorResponse({ res, statusCode: 404, message: "User not found" });
    }

    const user = rows[0];
    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return errorResponse({
        res,
        statusCode: 401,
        message: "Incorrect Password",
      });
    }

    const token = jwt.sign(
      { id: user.id, email: user.email, name: user.name, profile_photo: user.profile_photo },
      process.env.JWT_SECRET,
      { expiresIn: "8h" }
    );

    // res.cookie("auth_token", token, {
    //   httpOnly: true,
    //   secure: process.env.NODE_ENV === "production",
    //   // secure: true,
    //   sameSite: "Strict",
    //   maxAge: 3600000,
    // });

    successResponse({
      res,
      statusCode: 200,
      message: "Login successful",
      data: { token },
    });
  } catch (err) {
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};

export const getUser = async (req, res) => {
  try {
    const userId = req.user.id;

    const [user] = await db.execute(
      "SELECT id, name, email, profile_photo, created_at, updated_at FROM users WHERE id = ? LIMIT 1",
      [userId]
    );
    if (user.length === 0) {
      return errorResponse({ res, statusCode: 404, message: "User not found" });
    }

    successResponse({
      res,
      statusCode: 200,
      message: "Success fetching user data",
      data: user[0],
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
