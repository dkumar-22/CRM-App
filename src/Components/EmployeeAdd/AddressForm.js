import React from "react";
import Grid from "@material-ui/core/Grid";
import Typography from "@material-ui/core/Typography";
import TextField from "@material-ui/core/TextField";
import Select from "@material-ui/core/Select";
import MenuItem from "@material-ui/core/MenuItem";
import InputLabel from "@material-ui/core/InputLabel";
import { makeStyles } from "@material-ui/core/styles";
import FormControl from "@material-ui/core/FormControl";
// import FormHelperText from "@material-ui/core/FormHelperText";
// import { useDataLayerValue } from "../../DataLayer";
// import moment from "moment";


const useStyles = makeStyles((theme) => ({
  formControl: {
    margin: theme.spacing(1),
    minWidth: 120,
  },
  selectEmpty: {
    marginTop: theme.spacing(2),
  },
}));

export default function AddressForm({ details, handleDetails }) {

  const classes = useStyles();

  return (
    <React.Fragment>
      <Typography variant="h6" gutterBottom>
        Enter Employee Details
      </Typography>
      <Grid container spacing={3}>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="firstName"
            name="fname"
            label="First name"
            fullWidth
            autoComplete="given-name"
            value={details.fname}
            onChange={handleDetails}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="lastName"
            name="lname"
            label="Last name"
            fullWidth
            autoComplete="family-name"
            value={details.lname}
            onChange={handleDetails}
          />
        </Grid>
        <Grid xs={12}>
          <FormControl className={classes.formControl}>
            <InputLabel id="demo-simple-select-label">Gender</InputLabel>
            <Select
              labelId="demo-simple-select-label"
              id="demo-simple-select"
              value={details.gender}
              name="gender"
              autoComplete="Gender"
              onChange={handleDetails}
            >
              <MenuItem value={"Male"}>Male</MenuItem>
              <MenuItem value={"Female"}>Female</MenuItem>
              <MenuItem value={"Other"}>Other</MenuItem>
            </Select>
          </FormControl>
        </Grid>
        <Grid item xs={12}>
          <TextField
            required
            id="address"
            name="address"
            label="Address"
            fullWidth
            value={details.address}
            onChange={handleDetails}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="city"
            name="city"
            label="City"
            fullWidth
            autoComplete="shipping address-level2"
            value={details.city}
            onChange={handleDetails}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            id="state"
            name="state"
            label="State/Province/Region"
            fullWidth
            value={details.state}
            onChange={handleDetails}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="zip"
            name="zip"
            label="Zip / Postal code"
            fullWidth
            autoComplete="shipping postal-code"
            value={details.zip}
            onChange={handleDetails}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="phone"
            name="phone"
            label="Phone number"
            fullWidth
            autoComplete="Phone"
            value={details.phone}
            onChange={handleDetails}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            id="date"
            label="Date Of Birth"
            type="date"
            name="dob"
            InputLabelProps={{
              shrink: true,
            }}
            onChange={handleDetails}
            value={details.dob}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            id="doj"
            label="Date Of Joining"
            type="date"
            name="doj"
            InputLabelProps={{
              shrink: true,
            }}
            onChange={handleDetails}
            value={details.doj}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            required
            id="email"
            name="email"
            label="Email"
            fullWidth
            autoComplete="Email"
            value={details.email}
            onChange={handleDetails}
          />
        </Grid>
      </Grid>
    </React.Fragment>
  );
}
