import React, { useState } from "react";
import Button from "@material-ui/core/Button";
import CssBaseline from "@material-ui/core/CssBaseline";
import TextField from "@material-ui/core/TextField";
import Link from "@material-ui/core/Link";
import Box from "@material-ui/core/Box";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import Container from "@material-ui/core/Container";
import axios from "axios";
import MenuItem from "@material-ui/core/MenuItem";
import InputLabel from "@material-ui/core/InputLabel";
// import { Redirect } from "react-router";
import { useDataLayerValue } from "./DataLayer";
import Select from "@material-ui/core/Select";
import FormControl from "@material-ui/core/FormControl";

function Copyright() {
  return (
    <Typography variant="body2" color="textSecondary" align="center">
      {"Copyright © "}
      <Link color="inherit" href="/">
        Aumyaa
      </Link>{" "}
      {new Date().getFullYear()}
      {"."}
    </Typography>
  );
}

const useStyles = makeStyles((theme) => ({
  paper: {
    marginTop: theme.spacing(8),
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  form: {
    width: "100%",
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}));

export default function SignIn() {
  const [{ username }] = useDataLayerValue();
  const [details, setDetails] = useState({
    title: "",
    task: "",
    type: "",
    amount: "",
  });
  // const [updated, setUpdated] = useState(false);
  var currentdate = new Date();
  var date =
    currentdate.getDate() +
    "/" +
    (currentdate.getMonth() + 1) +
    "/" +
    currentdate.getFullYear();
  var time =
    currentdate.getHours() +
    ":" +
    currentdate.getMinutes() +
    ":" +
    currentdate.getSeconds();

  function handleChange(e) {
    const { name, value } = e.target;
    setDetails((prev) => {
      return { ...prev, [name]: value };
    });
  }
  function handleSubmit(e) {
    e.preventDefault();
    const obj = {
      title: details.title,
      task: details.task,
      type: details.type,
      amount: details.amount,
      date: date,
      time: time,
      addedBy: username,
    };
    console.log(obj);
    axios
      .post("http://localhost:5000/tasks/add", obj)
      .then((res) => {
        console.log(res.data);
        // setUpdated(true);
      })
      .catch((err) => console.log(err));
  }
  const classes = useStyles();
  // if (updated) {
  //   return <Redirect to="/" />;
  // }
  return (
    <Container
      component="main"
      maxWidth="xs"
      style={{ backgroundColor: "#fafafa" }}
    >
      <CssBaseline />
      <div className={classes.paper}>
        <Typography component="h1" variant="h5">
          Add Task
        </Typography>
        <form className={classes.form} onSubmit={handleSubmit}>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="title"
            label="Task Name"
            name="title"
            autoComplete="none"
            autoFocus
            value={details.title}
            onChange={handleChange}
          />
          <br />
          <FormControl fullWidth>
            <InputLabel id="demo-simple-select-label">Select Type:</InputLabel>
            <Select
              labelId="demo-simple-select-label"
              id="demo-simple-select"
              value={details.type}
              name="type"
              onChange={handleChange}
            >
              <MenuItem value={"purchase"}>Purchase</MenuItem>
              <MenuItem value={"payment"}>Payment</MenuItem>
              <MenuItem value={"task"}>Other</MenuItem>
            </Select>
          </FormControl>
          {(details.type === "purchase" || details.type === "payment") && (
            <TextField
              variant="outlined"
              margin="normal"
              required
              fullWidth
              id="amount"
              label="Amount"
              name="amount"
              autoComplete="none"
              value={details.amount}
              onChange={handleChange}
            />
          )}

          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="task"
            label="Task Description"
            name="task"
            autoComplete="none"
            value={details.task}
            onChange={handleChange}
            multiline
            minRows={9}
            maxRows={20}
          />

          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.submit}
          >
            Add Task
          </Button>
        </form>
      </div>
      <Box mt={8}>
        <Copyright />
      </Box>
    </Container>
  );
}
