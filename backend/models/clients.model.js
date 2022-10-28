const mongoose = require("mongoose");

const clientSchema = mongoose.Schema({
  registeredID: { type: String },
  name: { type: String },
  type: { type: String },
  gstNumber: { type: String },
  address: { type: String },
  city: { type: String },
  state: { type: String },
  zip: { type: String },
  phone: { type: String },
  email: { type: String },
  registeredDate: { type: String },
  ceoName: { type: String },
  ceoEmail: { type: String },
  ceoPhone: { type: String },
  additionalDetails: { type: Object },
});

const Client = mongoose.model("Client", clientSchema);

module.exports.Client = Client;
module.exports.clientSchema = clientSchema;
