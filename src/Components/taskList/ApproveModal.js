import React from "react";
import Modal from "@mui/material/Modal";
import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import Typography from "@mui/material/Typography";
import Box from "@mui/material/Box";

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

function ApproveModal({
  handleAccept,
  acceptOpen,
  handleAcceptClose,
  currcomments,
  handleChange,
}) {
  return (
    <>
      <Modal
        open={acceptOpen}
        onClose={handleAcceptClose}
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
          <Button
            size="small"
            style={{
              color: "green",
              padding: "8px",
              marginTop: "10px",
            }}
            onClick={handleAccept}
          >
            Approve
          </Button>
        </Box>
      </Modal>
    </>
  );
}

export default ApproveModal;
