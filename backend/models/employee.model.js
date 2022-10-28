const mongoose = require("mongoose");
const employeeSchema = mongoose.Schema({
  fname: { type: String },
  lname: { type: String },
  gender: { type: String },
  address: { type: String },
  city: { type: String },
  state: { type: String },
  zip: { type: String },
  phone: { type: String },
  email: { type: String },
  dob: { type: String },
  doj: { type: String },
  panNumber: { type: String },
  aadharNumber: { type: String },
  maritalStatus: { type: String },
  additionalDetails: { type: Object },
  isActive: { type: Boolean, default: false },
});

const Employee = mongoose.model("Employee", employeeSchema);

module.exports.Employee = Employee;
module.exports.employeeSchema = employeeSchema;