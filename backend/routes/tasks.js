const router = require("express").Router();

const PizZip = require("pizzip");
const Docxtemplater = require("docxtemplater");

const fs = require("fs");
const path = require("path");

let Task = require("../models/tasks.model");

function renderDoc(obj, companyName) {
  const content = fs.readFileSync(
    path.resolve(__dirname, "PolicyTemplate.docx"),
    "binary"
  );

  const zip = new PizZip(content);

  const doc = new Docxtemplater(zip, {
    paragraphLoop: true,
    linebreaks: true,
  });

  // Render the document (Replace {first_name} by John, {last_name} by Doe, ...)
  doc.render({
    ...obj,
  });

  const buf = doc.getZip().generate({
    type: "nodebuffer",
    // compression: DEFLATE adds a compression step.
    // For a 50MB output document, expect 500ms additional CPU time
    compression: "DEFLATE",
  });

  // buf is a nodejs Buffer, you can either write it to a
  // file or res.send it with express for example.
  fs.writeFileSync(
    path.resolve(
      __dirname + "/docs/",
      companyName.replaceAll(" ", "").toLowerCase() + ".docx"
    ),
    buf
  );

}

router.route("/add").post((req, res) => {
  const newTask = new Task({
    title: req.body.title,
    nameID: req.body.nameID,
    addedBy: req.body.addedBy,
    task: req.body.task,
    date: req.body.date,
    time: req.body.time,
    amount: req.body.amount,
    type: req.body.type,
    clientInfo: req.body.clientInfo,
    status: req.body.type === "payment" ? "1" : "0",
  });
  if (req.body.clientInfo !== undefined) {
    renderDoc(req.body.clientInfo, req.body.clientInfo.companyName);
  }
  newTask
    .save()
    .then(() => res.json("Task added!"))
    .catch((err) => res.status(400).json("Error: " + err));
});

router.route("/find/:status").get((req, res) => {
  Task.find({ status: req.params.status }, (err, rec) => {
    if (err) res.status(400).json("Error: " + err);
    else {
      res.json(rec);
    }
  });
});

router.route("/status/:companyName").get((req, res) => {
  Task.findOne({ nameID: req.params.companyName }, (err, rec) => {
    if (err) res.status(400).json("Error: " + err);
    else {
      if (rec.status === "Accepted")
        res.send({ status: true, companyName: rec.clientInfo.companyName });
      else res.send({ status: false, companyName: rec.clientInfo.companyName });
    }
  });
});
// { status: req.body.newpos },

router.route("/all").get((req, res) => {
  Task.find({}).then((data) => {
    res.send(data);
  });
});

router.route("/approved").get((req, res) => {
  Task.find({ status: "Accepted" }).then((data) => {
    res.send(data);
  });
});

router.route("/disapproved").get((req, res) => {
  Task.find({ status: "Disapproved" }).then((data) => {
    res.send(data);
  });
});

router.route("/pending").get(function (req, res) {
  Task.find(
    {
      $and: [
        { status: { $ne: "Accepted" } },
        { status: { $ne: "Disapproved" } },
      ],
    },
    function (err, result) {
      if (err) {
        res.send(err);
      } else {
        res.send(result);
      }
    }
  );
});

router.route("/:id").all((req, res) => {
  Task.findById(req.params.id)
    .then((exercise) => res.json(exercise))
    .catch((err) => res.status(400).json("Error: " + err));
});

router.route("/update/:id").all((req, res) => {
  Task.findByIdAndUpdate(
    req.params.id,
    { status: req.body.status, comments: req.body.comments },
    (err, rec) => {
      if (err) res.status(400).json("Error: " + err);
      else {
        console.log(req.body.status);
        res.json(rec);
      }
    }
  );
});

router.route("/count/:position").all((req, res) => {
  Task.countDocuments({ status: req.params.position }, (err, rec) => {
    if (err) res.status(400).json("Error: " + err);
    else {
      res.json(rec);
    }
  });
});

module.exports = router;
