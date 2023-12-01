const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const PORT = 3000;

const app = express();

const DB = "mongodb+srv://ishaanreddy28:ishaan.r7@cluster0.qaymsih.mongodb.net/?retryWrites=true&w=majority";

// Connect to MongoDB
mongoose.connect(DB, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log("Connected to MongoDB successfully!");
  })
  .catch((err) => {
    console.log("Error connecting to MongoDB:", err);
    process.exit(1);
  });

app.use(express.json());
app.use(authRouter);

// Listen for requests
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Listening on port ${PORT}`);
});
