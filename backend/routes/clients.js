const router = require("express").Router();
let Client= require("../models/clients.model");
Client = Client.Client;

router.route("/all").get((req, res) => {
  Client.find({}).then((data) => {
    res.send(data);
  });
});

router.route("/add").post((req, res) => {
  console.log(req.body);
  const client = new Client(req.body);
  client
    .save()
    .then((rec) => {
      console.log(rec);
      res.send(rec._id);
    })
    .catch((err) => res.status(400).json("Error: " + err));
});

// router.route("/add").post((req, res) => {
//   console.log(req.body);
// });

router.route("/status/:id").all((req, res) => {
  Client.findById(req.params.id)
    .then((rec) => {
      console.log(rec);
      console.log(typeof rec);
      res.send(rec);
    })
    .catch((err) => {
      console.log(err);
      res.send("Not Found");
    });
});

// router.route("/delete/:id").all((req, res) => {
//   Client.findByIdAndDelete(req.params.id)
//     .then(() => {
//       res.json("Client Deleted");
//     })
//     .catch((err) => res.status(400).json("Error: " + err));
// });
module.exports = router;
