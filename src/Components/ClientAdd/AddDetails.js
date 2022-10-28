import React from "react";
import Typography from "@material-ui/core/Typography";
import Grid from "@material-ui/core/Grid";
import TextField from "@material-ui/core/TextField";
// import InputLabel from "@material-ui/core/InputLabel";
import { makeStyles } from "@material-ui/core/styles";
// import FormControl from "@material-ui/core/FormControl";
// import Select from "@material-ui/core/Select";
// import MenuItem from "@material-ui/core/MenuItem";
import IconButton from "@material-ui/core/IconButton";
import RemoveIcon from "@material-ui/icons/Remove";
import AddIcon from "@material-ui/icons/Add";
import Button from "@material-ui/core/Button";

const useStyles = makeStyles((theme) => ({
  formControl: {
    margin: theme.spacing(1),
    minWidth: 120,
  },
  selectEmpty: {
    marginTop: theme.spacing(2),
  },
}));

export default function AddDetails({
  details,
  handleDetails,
  inputFields,
  handleSubmit,
  handleChangeInput,
  handleAddFields,
  handleRemoveFields,
}) {
  const classes = useStyles();

  // console.log(type);
  return (
    <>
      <React.Fragment>
        <Typography variant="h6" gutterBottom>
          CEO & Other Details
        </Typography>
        <Grid container spacing={3}>
          <Grid item xs={12} md={6}>
            <TextField
              required
              id="ceoName"
              name="ceoName"
              value={details.ceoName}
              onChange={handleDetails}
              label="Name of the CEO"
              fullWidth
            />
          </Grid>
          <Grid item xs={12} md={6}>
            <TextField
              required
              id="ceoEmail"
              name="ceoEmail"
              value={details.ceoEmail}
              onChange={handleDetails}
              label="Email of the CEO"
              fullWidth
            />
          </Grid>
          <Grid item xs={12} md={6}>
            <TextField
              required
              id="ceoPhone"
              name="ceoPhone"
              value={details.ceoPhone}
              onChange={handleDetails}
              label="Phone of the CEO"
              fullWidth
            />
          </Grid>
        </Grid>
      </React.Fragment>

      <br />
      <br />

      <React.Fragment>
        <Typography variant="h6" gutterBottom>
          Other Details
        </Typography>
        <React.Fragment>
          {inputFields.map((field) => (
            <Grid container spacing={3} key={field.id}>
              <Grid item xs={3} md={3}>
                <TextField
                  required
                  id="field"
                  name="key"
                  label="Field"
                  fullWidth
                  value={field.key}
                  onChange={(e) => handleChangeInput(field.id, e)}
                  autoComplete="key"
                />
              </Grid>
              <Grid item xs={6} md={6}>
                <TextField
                  required
                  id="val"
                  name="val"
                  value={field.val}
                  onChange={(e) => handleChangeInput(field.id, e)}
                  label="Value"
                  fullWidth
                  autoComplete="value"
                />
              </Grid>
              <IconButton
                disabled={inputFields.length === 1}
                onClick={() => handleRemoveFields(field.id)}
              >
                <RemoveIcon />
              </IconButton>
              <IconButton onClick={handleAddFields}>
                <AddIcon />
              </IconButton>
            </Grid>
          ))}
          <Button
            style={{ marginTop: "40px" }}
            className={classes.button}
            variant="contained"
            color="primary"
            type="submit"
            onClick={handleSubmit}
          >
            Confirm Fields
          </Button>
        </React.Fragment>
      </React.Fragment>
    </>
  );
}
