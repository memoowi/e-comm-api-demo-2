import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import db from "../config/db.mjs";
import { errorResponse, successResponse } from "../handler/responseHandler.mjs";

export const register = async (req, res) => {
  const { name, email, password } = req.body;

  // VALIDATE INPUT
  if (!name || !email || !password) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  try {
    // CHECK IF EMAIL EXIST
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

    // HASH THE PASSWORD
    const hashedPassword = await bcrypt.hash(password, 10);

    // INSERT THE NEW USER
    const [result] = await db.execute(
      "INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
      [name, email, hashedPassword]
    );

    // CREATE JWT TOKEN
    const token = jwt.sign(
      { id: result.insertId, email },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    // Send the token back to the client
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
  // VALIDATE INPUT
  if (!email || !password) {
    return errorResponse({
      res,
      statusCode: 400,
      message: "All fields are required",
    });
  }

  try {
    // CHECK IF USER EXIST
    const [rows] = await db.execute("SELECT * FROM users WHERE email = ?", [
      email,
    ]);
    if (rows.length === 0) {
      return errorResponse({ res, statusCode: 404, message: "User not found" });
    }

    // EXISTING USER
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
      { id: user.id, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    // Respond with success
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
    // Retrieve user ID from the authenticated token
    const userId = req.user.id;

    // Fetch user details from the database
    const [user] = await db.execute(
      "SELECT id, name, email, created_at, updated_at FROM users WHERE id = ?",
      [userId]
    );
    if (user.length === 0) {
      return errorResponse({ res, statusCode: 404, message: "User not found" });
    }

    // Respond with user details
    successResponse({
      res,
      statusCode: 200,
      message: "Success fetching user data",
      data: user,
    });
  } catch (error) {
    console.error(error);
    errorResponse({ res, statusCode: 500, message: "Internal Server Error" });
  }
};
