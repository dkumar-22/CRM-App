import React, { useState } from "react";
import Avatar from "@material-ui/core/Avatar";
import Button from "@material-ui/core/Button";
import CssBaseline from "@material-ui/core/CssBaseline";
import TextField from "@material-ui/core/TextField";
// import Link from "@material-ui/core/Link";
// import Grid from "@material-ui/core/Grid";
import Box from "@material-ui/core/Box";
import LockOutlinedIcon from "@material-ui/icons/LockOutlined";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import Container from "@material-ui/core/Container";
import axios from "axios";
import { useDataLayerValue } from "../../../DataLayer";
import md5 from "md5";
// import Cookies from "js-cookie";
//import { BrowserRouter } from 'react-router-dom';
import { Redirect } from "react-router";
// function Copyright({clicked,setClicked}) {
//   function sayHello() {
//     setClicked(!clicked);
//   }
//   return (
//     <Typography variant="body2" color="textSecondary" align="center">
//       {"Copyright © "}
//       <Link color="inherit" onClick={sayHello}>
//         Back to Main
//       </Link>{" "}
//       {new Date().getFullYear()}
//       {"."}
//     </Typography>
//   );
// }

const useStyles = makeStyles((theme) => ({
  paper: {
    marginTop: theme.spacing(8),
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: "#fafafa",
  },
  form: {
    width: "100%", // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}));

export default function SignIn({ clicked, setClicked }) {
  const [{ logged }, dispatch] = useDataLayerValue();

  const [details, setDetails] = useState({
    email: "",
    password: "",
  });
  function handleChange(e) {
    const { name, value } = e.target;
    setDetails((prev) => {
      return { ...prev, [name]: value };
    });
  }
  function handleSubmit(e) {
    e.preventDefault();
    console.log(details);

    async function post() {
      axios
        .post("http://localhost:5000/users/login", details)
        .then((res) => {
          console.log(res.data);
          if (
            res.data.email === details.email &&
            res.data.password === md5(details.password)
          ) {
            dispatch({
              type: "SET_USER",
              username: res.data.firstName + " " + res.data.lastName,
            });
            dispatch({
              type: "SET_LOGGED",
              logged: true,
            });
            dispatch({
              type: "SET_POSITION",
              position: res.data.position,
            });
            axios
              .get("http://localhost:5000/tasks/count/" + res.data.position)
              .then((res) => {
                console.log(res);
                dispatch({
                  type: "SET_APPROVALSCOUNT",
                  approvalsCount: res.data,
                });
              });
            // Cookies.set("loggedcookie", true);
            // Cookies.set("name", res.data.firstName);
          }
          //
          else alert("Something's Wrong");
        })
        .catch(() => {
          console.log("Error Occured");
        });
    }
    post();
  }
  const classes = useStyles();

  if (logged === true) {
    return <Redirect to="/dashboard" />;
  }

  return (
    <Container
      component="main"
      maxWidth="xs"
      style={{ backgroundColor: "#fafafa" }}
    >
      <CssBaseline />
      <div className={classes.paper}>
        <Avatar className={classes.avatar}>
          <LockOutlinedIcon />
        </Avatar>
        <Typography component="h1" variant="h5">
          Sign in
        </Typography>
        <form className={classes.form} onSubmit={handleSubmit}>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="email"
            label="Email Address"
            name="email"
            autoComplete="email"
            autoFocus
            value={details.email}
            onChange={handleChange}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            type="password"
            id="password"
            autoComplete="current-password"
            onChange={handleChange}
            value={details.password}
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.submit}
          >
            Sign In
          </Button>
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.submit}
            onClick={() => {
              setClicked(!clicked);
            }}
          >
            Back To Main Page
          </Button>
          {/* <Grid container>
            <Grid item xs></Grid>
            <Grid item>
              <Link href="/admin/register" variant="body2">
                {"Don't have an account? Sign Up"}
              </Link>
            </Grid>
          </Grid> */}
        </form>
      </div>
      <Box mt={8}>{/* <Copyright /> */}</Box>
    </Container>
  );
}
