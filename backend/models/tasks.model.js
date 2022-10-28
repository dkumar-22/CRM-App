const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const task = new Schema({
  title: { type: String },
  nameID: { type: String },
  addedBy: { type: String },
  task: { type: String },
  date: { type: String },
  time: { type: String },
  comments: { type: Array },
  status: { type: String },
  type: { type: String },
  amount: { type: Number },
  clientInfo: { type: Object },
});

const Task = mongoose.model("Task", task);

module.exports = Task;
