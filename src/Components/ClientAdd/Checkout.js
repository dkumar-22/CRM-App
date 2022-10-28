import React, { useState } from "react";
import { makeStyles } from "@material-ui/core/styles";
import CssBaseline from "@material-ui/core/CssBaseline";
import Paper from "@material-ui/core/Paper";
import Stepper from "@material-ui/core/Stepper";
import Step from "@material-ui/core/Step";
import StepLabel from "@material-ui/core/StepLabel";
import Button from "@material-ui/core/Button";
import Link from "@material-ui/core/Link";
import Typography from "@material-ui/core/Typography";
import AddressForm from "./AddressForm";
import Checkout2 from "./AddDetails";
import { v4 as uuidv4 } from "uuid";
import axios from "axios";
import { useDataLayerValue } from "../../DataLayer";

function Copyright() {
  return (
    <Typography variant="body2" color="textSecondary" align="center">
      {"Copyright © "}
      <Link color="inherit" href="/">
        Aumyaa Consulting Services LLP
      </Link>{" "}
      {new Date().getFullYear()}
      {"."}
      <br />
      <br />
    </Typography>
  );
}

const useStyles = makeStyles((theme) => ({
  appBar: {
    position: "relative",
  },
  layout: {
    width: "auto",
    marginLeft: theme.spacing(2),
    marginRight: theme.spacing(2),
    [theme.breakpoints.up(600 + theme.spacing(2) * 2)]: {
      width: 600,
      marginLeft: "auto",
      marginRight: "auto",
    },
  },
  paper: {
    marginTop: theme.spacing(3),
    marginBottom: theme.spacing(3),
    padding: theme.spacing(2),
    [theme.breakpoints.up(600 + theme.spacing(3) * 2)]: {
      marginTop: theme.spacing(6),
      marginBottom: theme.spacing(6),
      padding: theme.spacing(3),
    },
  },
  stepper: {
    padding: theme.spacing(3, 0, 5),
  },
  buttons: {
    display: "flex",
    justifyContent: "flex-end",
  },
  button: {
    marginTop: theme.spacing(3),
    marginLeft: theme.spacing(1),
  },
}));

const steps = ["Company Details", "CEO & Other Details"];

export default function Checkout() {
  const [activeStep, setActiveStep] = useState(0);

  const [{ id }, dispatch] = useDataLayerValue();
  const classes = useStyles();

  const [details, setDetails] = useState({
    registeredID: "",
    name: "",
    type: "",
    gstNumber: "",
    address: "",
    city: "",
    state: "",
    zip: "",
    phone: "",
    email: "",
    registeredDate: "",
    ceoName: "",
    ceoEmail: "",
    ceoPhone: "",
  });
  // console.log(details.slot);
  const [inputFields, setInputFields] = useState([
    { id: uuidv4(), key: "", val: "" },
  ]);

  function handleDetails(e) {
    const { name, value } = e.target;
    setDetails((prev) => {
      return { ...prev, [name]: value };
    });
  }

  const handleNext = () => {
    setActiveStep(activeStep + 1);
  };

  const handleBack = () => {
    setActiveStep(activeStep - 1);
  };

  const [d2, addD2] = useState({});

  const handleSubmit = (e) => {
    e.preventDefault();
    var object = inputFields.reduce(
      (obj, item) => Object.assign(obj, { [item.key]: item.val }),
      {}
    );
    addD2((prev) => ({
      ...prev,
      ...object,
    }));
  };
  const handleChangeInput = (id, event) => {
    const newInputFields = inputFields.map((i) => {
      if (id === i.id) {
        i[event.target.name] = event.target.value;
      }
      return i;
    });

    setInputFields(newInputFields);
  };

  const handleAddFields = () => {
    setInputFields([...inputFields, { id: uuidv4(), key: "", val: "" }]);
  };

  const handleRemoveFields = (id) => {
    const values = [...inputFields];
    values.splice(
      values.findIndex((value) => value.id === id),
      1
    );
    setInputFields(values);
  };

  function getStepContent(step) {
    switch (step) {
      case 0:
        return (
          <AddressForm
            details={details}
            setDetails={setDetails}
            handleDetails={handleDetails}
          />
        );
      case 1:
        return (
          <Checkout2
            inputFields={inputFields}
            handleSubmit={handleSubmit}
            handleChangeInput={handleChangeInput}
            handleAddFields={handleAddFields}
            handleRemoveFields={handleRemoveFields}
            details={details}
            setDetails={setDetails}
            handleDetails={handleDetails}
          />
        );
      default:
        throw new Error("Unknown step");
    }
  }
  React.useEffect(() => {
    // console.log(activeStep);
    if (activeStep === steps.length) {
      axios
        .post("http://localhost:5000/clients/add", {
          ...details,
          additionalDetails: d2,
        })
        .then((res) => {
          console.log(res.data);
          dispatch({
            type: "SET_ID",
            id: res.data,
          });
        })
        .catch((err) => console.log(err));
    }
  }, [activeStep, d2, details, dispatch]);


// const submitForm = (e) => {
//   handleSubmit(e);
//   axios
//     .post("http://localhost:5000/client/add", {
//       ...details,
//       additionalDetails: d2,
//     })
//     .then((res) => {
//       console.log(res.data);
//       dispatch({
//         type: "SET_ID",
//         id: res.data,
//       });
//     })
//     .catch((err) => console.log(err));
// }


  return (
    <React.Fragment>
      <CssBaseline />
      <main className={classes.layout} style={{backgroundColor:"#fafafa"}}>
        <Paper className={classes.paper}>
          <Typography component="h1" variant="h4" align="center">
            Addition of a New Client
          </Typography>
          <Stepper activeStep={activeStep} className={classes.stepper}>
            {steps.map((label) => (
              <Step key={label}>
                <StepLabel>{label}</StepLabel>
              </Step>
            ))}
          </Stepper>
          <React.Fragment>
            {activeStep === steps.length ? (
              <React.Fragment>
                <Typography variant="h5" gutterBottom>
                  Client was added Successfully
                </Typography>
                <Typography variant="subtitle1">
                  Client Added Successfully. <br /> Client ID:{" "}
                  <strong>{id}</strong>
                </Typography>
              </React.Fragment>
            ) : (
              <React.Fragment>
                {getStepContent(activeStep)}
                <div className={classes.buttons}>
                  {activeStep !== 0 && activeStep !== 2 && (
                    <Button onClick={handleBack} className={classes.button}>
                      Back
                    </Button>
                  )}

                  {activeStep === steps.length - 1 ? (
                    <Button
                      variant="contained"
                      color="primary"
                      onClick={handleNext}
                      className={classes.button}
                    >
                      Add Client
                    </Button>
                  ) : (
                    <Button
                      variant="contained"
                      color="primary"
                      onClick={handleNext}
                      className={classes.button}
                    >
                      Next
                    </Button>
                  )}
                </div>
              </React.Fragment>
            )}
          </React.Fragment>
        </Paper>
        <Copyright />
      </main>
    </React.Fragment>
  );
}
