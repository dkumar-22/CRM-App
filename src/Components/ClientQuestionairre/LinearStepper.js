import React, { useState } from "react";
import {
  Typography,
  TextField,
  Button,
  Stepper,
  Step,
  StepLabel,
} from "@mui/material";
import { makeStyles } from "@mui/styles";
import {
  useForm,
  Controller,
  FormProvider,
  useFormContext,
} from "react-hook-form";
import axios from "axios";
import "./styles.css"
const useStyles = makeStyles((theme) => ({
  button: {
    marginRight: "8",
  },
}));

function getSteps() {
  return [
    "Company Basic information",
    "Dates and Version Info", // "Contact Information",
    "Responsibilities Information",
    "Information Security Organizational Structure",
    "Declaration and Incident Handling",
  ];
}
const BasicForm = () => {
  const { control } = useFormContext();
  const [image, setImage] = useState({ preview: "", data: "", name: "" });
  const handleFileChange = (e) => {
    const img = {
      preview: URL.createObjectURL(e.target.files[0]),
      data: e.target.files[0],
      name: e.target.files[0].name,
    };
    setImage(img);
  };

  const uploadFile = async (e) => {
    const formData = new FormData();
    formData.append("file", image.data);
    formData.append("fileName", image.name);
    try {
      const res = await axios.post("http://localhost:5000/upload", formData);
      console.log(res);
    } catch (ex) {
      console.log(ex);
    }
  };

  return (
    <>
      <h3>Add Logo</h3>
      <input
        type="file"
        accept="image/*"
        name="file"
        id="file"
        onChange={handleFileChange}
      />
      <button className="btnstyle" onClick={uploadFile}>Upload</button>
      <br />
      <br />
      {image.preview && (
        <img src={image.preview} width="100" height="100" alt="logo" />
      )}
      {/* <input type="submit" value="Upload" /> */}
      {/* </form> */}
      <Controller
        control={control}
        name="companyName"
        render={({ field }) => (
          <TextField
            id="companyName"
            label="Company Name"
            variant="outlined"
            placeholder="Enter Your Company Name"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
      <Controller
        control={control}
        name="CEO"
        render={({ field }) => (
          <TextField
            id="CEO"
            label="CEO Name"
            variant="outlined"
            placeholder="CEO Name"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
      <Controller
        control={control}
        name="CTO"
        render={({ field }) => (
          <TextField
            id="CTO"
            label="CTO Name"
            variant="outlined"
            placeholder="CTO"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
      {/* image buploading buttons  */}
      {/* <div>
                <ImageUploading
                    multiple
                    value={images}
                    onChange={onChange}
                    maxNumber={maxNumber}
                    dataURLKey="data_url"
                    acceptType={["jpg"]}
                >
                    {({
                        imageList,
                        onImageUpload,
                        onImageRemoveAll,
                        onImageUpdate,
                        onImageRemove,
                        isDragging,
                        dragProps
                    }) => (
                        // write your building UI
                        <div className="upload__image-wrapper">
                            <button
                                style={isDragging ? { color: "red" } : null}
                                onClick={onImageUpload}
                                {...dragProps}
                            >
                                Upload Company Logo
                            </button>
                            &nbsp;
                            <button onClick={onImageRemoveAll}>Remove Logo</button>
                            {imageList.map((image, index) => (
                                <div key={index} className="image-item">
                                    <img src={image.data_url} alt="" width="100" />
                                    <div className="image-item__btn-wrapper">
                                        <button onClick={() => onImageUpdate(index)}>Update</button>
                                        <button onClick={() => onImageRemove(index)}>Remove</button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                </ImageUploading> */}
      {/* </div> */}
    </>
  );
};
const VersionForm = () => {
  const { control } = useFormContext();
  return (
    <>
      <Controller
        control={control}
        name="issueDate"
        render={({ field }) => (
          <TextField
            id="issueDate"
            label="Issue Date"
            variant="outlined"
            placeholder="Enter Issue Date"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="reviewDate"
        render={({ field }) => (
          <TextField
            id="reviewDate"
            label="Review Date"
            variant="outlined"
            placeholder="Enter Review Date"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
      <Controller
        control={control}
        name="nextReviewDate"
        render={({ field }) => (
          <TextField
            id="nextReviewDate"
            label="Next Review Phone"
            variant="outlined"
            placeholder="Enter Next Review Date"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
      <Controller
        control={control}
        name="version"
        render={({ field }) => (
          <TextField
            id="version"
            label="Version"
            variant="outlined"
            placeholder="Enter The Version Number"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
    </>
  );
};
const ResponsibilitiesForm = () => {
  const { control } = useFormContext();
  return (
    <>
      <Controller
        control={control}
        name="approverName"
        render={({ field }) => (
          <TextField
            id="approverName"
            label="Approver Name"
            variant="outlined"
            placeholder="Enter Approver Name"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="approverDesignation"
        render={({ field }) => (
          <TextField
            id="approverDesignation"
            label="Approver Designation"
            variant="outlined"
            placeholder="Enter Approver Designation"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="reviewerName"
        render={({ field }) => (
          <TextField
            id="reviewerName"
            label="Reviewer Name"
            variant="outlined"
            placeholder="Enter Reviewer Name"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="reviewerDesignation"
        render={({ field }) => (
          <TextField
            id="reviewerDesignation"
            label="Reviewer Designation"
            variant="outlined"
            placeholder="Enter Reviewer Designation"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="preparedBy"
        render={({ field }) => (
          <TextField
            id="preparedBy"
            label="Report prepared By"
            variant="outlined"
            placeholder="Report Prepared By"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
    </>
  );
};
const ITForm = () => {
  const { control } = useFormContext();
  return (
    <>
      <Controller
        control={control}
        name="ITHeadName"
        render={({ field }) => (
          <TextField
            id="ITHeadName"
            label="IT Head Name"
            variant="outlined"
            placeholder="Enter IT Head Name"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="ITHeadDesignation"
        render={({ field }) => (
          <TextField
            id="ITHeadDesignation"
            label="IT Head Designation"
            variant="outlined"
            placeholder="Designation of  IT and Project  Head"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="SecurityManagerName"
        render={({ field }) => (
          <TextField
            id="SecurityManagerName"
            label="Security Manager Name"
            variant="outlined"
            placeholder="Name of  Security Manager"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="SecurityManagerDesignation"
        render={({ field }) => (
          <TextField
            id="SecurityManagerDesignation"
            label="Security Manager Designation"
            variant="outlined"
            placeholder="Designation of  Security Manager"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="SecurityComplianceCommittee"
        render={({ field }) => (
          <TextField
            id="SecurityComplianceCommittee"
            label="Security Compliance Committee"
            variant="outlined"
            placeholder="Security Compliance Committee"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="nameOfSecurityHead"
        render={({ field }) => (
          <TextField
            id="nameOfSecurityHead"
            label="Name Of Security Head"
            variant="outlined"
            placeholder="Name Of Security Head"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />

      <Controller
        control={control}
        name="designationOfSecurityHead"
        render={({ field }) => (
          <TextField
            id="designationOfSecurityHead"
            label="Designation Of Security Head"
            variant="outlined"
            placeholder="Designation Of Security Head"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
      <Controller
        control={control}
        name="ContactAuthorities"
        render={({ field }) => (
          <TextField
            id="contactAuthorities"
            label="Contact with Authorities"
            variant="outlined"
            placeholder="Enter Name for person responsible for contact with Authorities"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
    </>
  );
};

const Declaration = () => {
  const { control } = useFormContext();
  return (
    <>
      <Controller
        control={control}
        name="incidentHandlingMail"
        render={({ field }) => (
          <TextField
            id="incidentHandlingMail"
            label="Incident Handling Email"
            variant="outlined"
            placeholder="Enter Email for Incident Handling"
            fullWidth
            margin="normal"
            {...field}
          />
        )}
      />
    </>
  );
};

const LinaerStepper = () => {
  const classes = useStyles();
  const methods = useForm({
    defaultValues: {
      companyName: "",
      CEO: "",
      CTO: "",
      issueDate: "",
      reviewDate: "",
      nextReviewDate: "",
      version: "",
      approverName: "",
      approverDesignation: "",
      reviewerName: "",
      reviewerDesignation: "",
      ITHeadName: "",
      ITHeadDesignation: "",
      SecurityManagerName: "",
      SecurityManagerDesignation: "",
      SecurityComplianceCommittee: "",
      ContactAuthorities: "",
      incidentHandlingMail: "",
      designationOfSecurityHead: "",
      nameOfSecurityHead: "",
      preparedBy: "Aumyaa",
    },
  });

  //for file upload
  const [image, setImage] = useState({ preview: "", data: "" });

  function getStepContent(step) {
    switch (step) {
      case 0:
        return <BasicForm image={image} setImage={setImage} />;
      case 1:
        return <VersionForm />;
      case 2:
        return <ResponsibilitiesForm />;
      case 3:
        return <ITForm />;
      case 4:
        return <Declaration />;
      default:
        return "unknown step";
    }
  }

  // const [selectedFile,setSelectedFile] =useState(null);
  const [activeStep, setActiveStep] = useState(0);
  const [skippedSteps, setSkippedSteps] = useState([]);
  const steps = getSteps();

  const isStepOptional = (step) => {
    return step === 1 || step === 2;
  };

  const isStepSkipped = (step) => {
    return skippedSteps.includes(step);
  };

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

  const handleNext = (data) => {
    console.log(data);
    // when user submits multi-step form

    if (activeStep === steps.length - 1) {
      axios
        .post("http://localhost:5000/tasks/add", {
          nameID: data.companyName.replace(" ", "").toLowerCase(),
          title: data.companyName + "'s Questionairre",
          task: "Answered Queries for " + data.companyName,
          type: "Questionairre Responses",
          date: date,
          time: time,
          addedBy: data.companyName,
          clientInfo: {
            ...data,
          },
        })
        .then((res) => {
          console.log(res);
        })
        .catch((err) => console.log(err));
      setActiveStep(activeStep + 1);
    } else {
      setActiveStep(activeStep + 1);
      setSkippedSteps(
        skippedSteps.filter((skipItem) => skipItem !== activeStep)
      );
    }
  };

  const handleBack = () => {
    setActiveStep(activeStep - 1);
  };

  // const handleSkip = () => {
  //   if (!isStepSkipped(activeStep)) {
  //     setSkippedSteps([...skippedSteps, activeStep]);
  //   }
  //   setActiveStep(activeStep + 1);
  // };

  //function to create file/run bash script
  const policyCreater = () => {
    console.log("running backend script");
  };

  // const onSubmit = (data) => {
  //   console.log(data);
  // };
  return (
    <div>
      <Stepper alternativeLabel activeStep={activeStep}>
        {steps.map((step, index) => {
          const labelProps = {};
          const stepProps = {};
          if (isStepOptional(index)) {
            labelProps.optional = (
              <Typography
                variant="caption"
                align="center"
                style={{ display: "block" }}
              ></Typography>
            );
          }
          if (isStepSkipped(index)) {
            stepProps.completed = false;
          }
          return (
            <Step {...stepProps} key={index}>
              <StepLabel {...labelProps}>{step}</StepLabel>
            </Step>
          );
        })}
      </Stepper>

      {activeStep === steps.length ? (
        <div style={{ textAlign: "center" }}>
          <Typography variant="h3" align="center">
            Thank You
          </Typography>
          <br />
          <br />
          <a
            href="http://localhost:5000/windows"
            download
            style={{ textDecoration: "none" }}
          >
            <Button
              className={classes.button}
              disabled={activeStep === 0}
              onClick={policyCreater}
            >
              Download Script for Windows
            </Button>
          </a>
          <a
            href="http://localhost:5000/linux"
            download
            style={{ textDecoration: "none" }}
          >
            <Button
              className={classes.button}
              disabled={activeStep === 0}
              onClick={policyCreater}
            >
              Download Script for Linux
            </Button>
          </a>
          <a
            href="http://localhost:5000/redhat"
            download
            style={{ textDecoration: "none" }}
          >
            <Button
              className={classes.button}
              disabled={activeStep === 0}
              onClick={policyCreater}
            >
              Download Script for Redhat
            </Button>
          </a>
        </div>
      ) : (
        <>
          <FormProvider {...methods}>
            <form onSubmit={methods.handleSubmit(handleNext)}>
              {getStepContent(activeStep)}

              <Button
                className={classes.button}
                disabled={activeStep === 0}
                onClick={handleBack}
              >
                back
              </Button>
              {/* {isStepOptional(activeStep) && (
                                <Button
                                    className={classes.button}
                                    variant="contained"
                                    color="primary"
                                    onClick={handleSkip}
                                >
                                    skip
                                </Button>
                            )} */}
              <Button
                className={classes.button}
                variant="contained"
                color="primary"
                // onClick={handleNext}
                type="submit"
              >
                {activeStep === steps.length - 1 ? "Finish" : "Next"}
              </Button>
            </form>
          </FormProvider>
        </>
      )}
    </div>
  );
};

export default LinaerStepper;
