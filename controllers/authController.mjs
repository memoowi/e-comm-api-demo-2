import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import db from "../config/db.mjs";

export const register = async (req, res) => {
  const { name, email, password } = req.body;

  // VALIDATE INPUT
  if (!name || !email || !password)
    return res.status(400).json({ error: "All fields are required" });

  try {
    // CHECK IF EMAIL EXIST
    const [existingUser] = await db.execute(
      "SELECT * FROM users WHERE email = ?",
      [email]
    );
    if (existingUser.length > 0) {
      return res.status(409).json({ error: "Email is already registered" });
    }

    // HASH THE PASSWORD
    const hashedPassword = await bcrypt.hash(password, 10);

    // INSERT THE NEW USER
    const [result] = await db.execute(
      "INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
      [name, email, hashedPassword]
    );
    res
      .status(201)
      .json({ message: "User Registered", userId: result.insertId });
  } catch (err) {
    res.status(500).json({ error: "Database Error" });
  }
};

export const login = async (req, res) => {
  const { email, password } = req.body;
  // VALIDATE INPUT
  if (!email || !password)
    return res.status(400).json({ error: "All fields are required" });

  try {
    // CHECK IF USER EXIST
    const [rows] = await db.execute("SELECT * FROM users WHERE email = ?", [
      email,
    ]);
    if (rows.length === 0)
      return res.status(401).json({ error: "User not found" });

    // EXISTING USER
    const user = rows[0];
    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword)
      return res.status(401).json({ error: "Incorrect Password" });

    const token = jwt.sign(
      { id: user.id, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    // Respond with success
    res.status(200).json({
      message: "Login successful",
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
      },
    });
  } catch (err) {
    res.status(500).json({ error: "Database Error" });
  }
};

export const getUser = async (req, res) => {
  try {
    // Retrieve user ID from the authenticated token
    const userId = req.user.id;

    // Fetch user details from the database
    const [user] = await db.execute('SELECT id, name, email, created_at, updated_at FROM users WHERE id = ?', [userId]);
    if (user.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Respond with user details
    res.status(200).json(user[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'An error occurred while fetching user details' });
  }
};
