const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const user = new Schema(
  {
    firstName: { type: String },
    lastName: { type: String },
    position: { type: String },
    email: { type: String },
    password: { type: String },
  }
);

const User = mongoose.model("User", user);

module.exports = User;
