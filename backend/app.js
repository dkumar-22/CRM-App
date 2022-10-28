const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const employeeRouter = require("./routes/employees");
const bodyParser = require("body-parser");
const usersRouter = require("./routes/users");
const tasksRouter = require("./routes/tasks");
const clientsRouter = require("./routes/clients");
const fileupload = require("express-fileupload");

mongoose.set("useFindAndModify", false);
require("dotenv").config();

var toPdf = require("office-to-pdf");
const fs = require("fs");
const path = require("path");

const app = express();
const port = process.env.PORT || 5000;
app.use(bodyParser.urlencoded({ extended: false }));
app.use(fileupload());
app.use(cors());
app.options("*", cors());
app.use(express.json());

const uri = process.env.ATLAS;
//const uri2 = "mongodb://localhost:27017/userDB";
mongoose.connect(uri, {
  useNewUrlParser: true,
  useCreateIndex: true,
  useUnifiedTopology: true,
});
const connection = mongoose.connection;
connection.once("open", () => {
  console.log("MongoDB database connection established successfully");
});

app.post("/upload", (req, res) => {
  const newpath = __dirname + "/files/";
  const file = req.files.file;
  const filename = file.name;

  file.mv(`${newpath}${filename}`, (err) => {
    if (err) {
      res.status(500).send({ message: "File upload failed", code: 200 });
    }
    res.status(200).send({ message: "File Uploaded", code: 200 });
  });
});

app.get("/", (req, res) => {
  res.send("Hello World");
});

app.get("/word/:download", (req, res) => {
  const companyName = req.params.download;
  // var wordBuffer = fs.readFileSync(
  //   path.resolve(__dirname + "/routes/docs/", companyName + ".docx")
  // );

  // toPdf(wordBuffer).then(
  //   (pdfBuffer) => {
  //     fs.writeFileSync(
  //       path.resolve(__dirname + "/routes/docs/", companyName + ".pdf"),
  //       pdfBuffer
  //     );
  //   },
  //   (err) => {
  //     console.log(err);
  //   }
  // );
  res.download("./routes/docs/" + companyName + ".docx");
});

app.get("/windows", (req, res) => res.download("./Scripts/windows.ps1"));

app.get("/linux", (req, res) =>
  res.download("./Scripts/Script_AIX_20111230.sh")
);

app.get("/redhat", (req, res) =>
  res.download("./Scripts/Script_Red_Hat_Enterprise_Linux_20111230.sh")
);

// app.use("/exercises", exercisesRouter);
app.use("/users", usersRouter);
app.use("/employee", employeeRouter);
app.use("/tasks", tasksRouter);
app.use("/clients", clientsRouter);

app.listen(port, () => {
  console.log(`Server is running on port: ${port}`);
});
