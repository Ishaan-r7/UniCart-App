const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

// POST route for user signup
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body; // Get client data
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ msg: 'User with the same email already exists' });
    }

    let user = new User({
      name,
      email,
      password,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// POST route for user login
authRouter.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body; // Get client data
    const user = await User.findOne({ email });

    if (user && await user.comparePassword(password)) {
      res.json({ msg: 'Login successful' });
    } else {
      res.status(401).json({ msg: 'Sign-in details don\'t exist. Please sign up again.' });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
