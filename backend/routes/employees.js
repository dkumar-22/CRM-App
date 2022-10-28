const router = require("express").Router();
let Employee = require("../models/employee.model");
Employee = Employee.Employee;

router.route("/all").get((req, res) => {
  Employee.find({ isDeleted: false }).then((data) => {
    res.send(data);
  });
});

router.route("/add").post((req, res) => {
  console.log(req.body);
  const employee = new Employee(req.body);
  employee
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
  Employee.findById(req.params.id)
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


router.route("/delete/:id").all((req, res) => {
  Employee.findByIdAndUpdate(req.params.id, { isDeleted: true }, (err, rec) => {
    if (err) res.status(400).json("Error: " + err);
    else {
      console.log(req.body.status);
      res.json(rec);
    }
  });
});

module.exports = router;
