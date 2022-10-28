import React from "react";
import Modal from "@mui/material/Modal";
import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import Typography from "@mui/material/Typography";
import Box from "@mui/material/Box";
import Select from "@material-ui/core/Select";
import MenuItem from "@material-ui/core/MenuItem";
import InputLabel from "@material-ui/core/InputLabel";
import FormControl from "@material-ui/core/FormControl";
// import { positions } from "../../postions";

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 400,
  bgcolor: "background.paper",
  border: "2px solid #000",
  boxShadow: 24,
  p: 4,
};

function RejectModal({
  status,
  rejectOpen,
  handleRejectClose,
  currcomments,
  handleChange,
  rbStatus,
  handleRbStatus,
  handleReject,
  type,
}) {
  return (
    <>
      <Modal
        open={rejectOpen}
        onClose={handleRejectClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          <Typography id="modal-modal-title" variant="h6" component="h2">
            Add Comments
          </Typography>
          <TextField
            fullWidth
            id="standard-textarea"
            label="Add Suitable Comments"
            placeholder="Comments"
            multiline
            variant="standard"
            value={currcomments}
            onChange={handleChange}
          />
          <br />
          <br />
          <FormControl fullWidth>
            <InputLabel id="demo-simple-select-label">
              Refer Back To:
            </InputLabel>
            <Select
              labelId="demo-simple-select-label"
              id="demo-simple-select"
              value={rbStatus}
              name="rbStatus"
              onChange={handleRbStatus}
            >
              {parseInt(status) >= 4 && <MenuItem value={"3"}>D</MenuItem>}
              {parseInt(status) >= 3 && <MenuItem value={"2"}>C</MenuItem>}
              {parseInt(status) >= 2 && <MenuItem value={"1"}>B</MenuItem>}
              {type !== "payment" && parseInt(status) >= 1 && (
                <MenuItem value={"0"}>A</MenuItem>
              )}
              {type !== "payment" &&
                type !== "purchase" &&
                parseInt(status) >= 0 && (
                  <MenuItem value={"Employee"}>Employee</MenuItem>
                )}
            </Select>
          </FormControl>
          <Button
            size="small"
            style={{
              color: "crimson",
              padding: "8px",
              marginTop: "10px",
              display: "block",
            }}
            onClick={handleReject}
          >
            Refer Back
          </Button>
        </Box>
      </Modal>
    </>
  );
}

export default RejectModal;
