import React, { useState } from "react";
import axios from "axios";
import Card from "@mui/material/Card";
import CardActions from "@mui/material/CardActions";
import CardContent from "@mui/material/CardContent";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import Modal from "@mui/material/Modal";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import { Redirect } from "react-router";

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

export default function BasicCard({
  title,
  task,
  id,
  position,
  status,
  date,
  time,
  comments,
}) {
  function nextChar(c) {
    const str = String.fromCharCode(c.charCodeAt(0) + 1);
    return str === "E" ? "Accepted" : str;
  }

  function prevChar(c) {
    return String.fromCharCode(c.charCodeAt(0) - 1);
  }

  const styles = {
    backgroundColor: "#DDDDDD",
    boxShadow: "4px 6px 8px rgba(0, 0, 0, 0.247)",
  };

  const n = comments.length;

  const [acceptOpen, setAcceptOpen] = React.useState(false);
  const handleAcceptOpen = () => setAcceptOpen(true);
  const handleAcceptClose = () => setAcceptOpen(false);

  const [rejectOpen, setRejectOpen] = React.useState(false);
  const handleRejectOpen = () => setRejectOpen(true);
  const handleRejectClose = () => setRejectOpen(false);

  const [currcomments, setcurrComments] = useState("");
  const [updated, setUpdated] = useState(false);

  function handleChange(e) {
    console.log(e.target.value);
    setcurrComments(e.target.value);
  }

  // console.log(id);
  function handleAccept() {
    axios
      .post("http://localhost:5000/tasks/update/" + id, {
        status: nextChar(status),
        comments: [...comments, currcomments],
      })
      .then((res) => {
        console.log(res.data);
        setUpdated(true);
      })
      .catch((err) => console.log(err));
  }

  function handleReject() {
    axios
      .post("http://localhost:5000/tasks/update/" + id, {
        status: prevChar(status),
        comments: currcomments,
      })
      .then((res) => {
        console.log(res.data);
        setUpdated(true);
      })
      .catch((err) => console.log(err));
  }

  if (updated) {
    return <Redirect to="/tasks" />;
  }

  return (
    <>
      <Card sx={{ minWidth: 275 }} style={styles}>
        <CardContent>
          <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
            Date and Time: {date + " " + time}
          </Typography>
          <Typography variant="h5" component="div">
            {title}
          </Typography>
          <Typography sx={{ mb: 1.5 }} color="text.secondary">
            Status: {status}
          </Typography>
          <Typography variant="body2">
            <Typography
              sx={{ fontSize: 14 }}
              color="text.secondary"
              gutterBottom
            >
              Task Description:{" "}
            </Typography>
            {task}
            <br />
          </Typography>
          <br />
          <div className="currComment">
            <Typography
              sx={{ fontSize: 14 }}
              color="text.secondary"
              gutterBottom
            >
              Last Comment:{" "}
            </Typography>
            <Typography variant="body2">{comments[n - 1]}</Typography>
          </div>

          <br />
          <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
            Previous Comments:{" "}
          </Typography>
          {comments !== undefined &&
            comments.map(function (comment, index) {
              return (
                index < n - 1 && (
                  <div key="c++">
                    <Typography variant="body2">{comment}</Typography>
                  </div>
                )
              );
            })}
        </CardContent>
        {status === position && (
          <CardActions style={{ marginBottom: "8px" }}>
            {status !== "A" && (
              <Button
                size="small"
                style={{
                  backgroundColor: "crimson",
                  color: "white",
                  marginLeft: "5px",
                  padding: "8px",
                }}
                onClick={handleRejectOpen}
              >
                Reject
              </Button>
            )}
            <Button
              size="small"
              style={{
                backgroundColor: "black",
                color: "white",
                marginLeft: "5px",
                padding: "8px",
              }}
              onClick={handleAcceptOpen}
            >
              Accept
            </Button>
          </CardActions>
        )}
      </Card>

      <div>
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
                backgroundColor: "black",
                color: "white",
                padding: "8px",
                marginTop: "10px",
              }}
              onClick={handleAccept}
            >
              Approve
            </Button>
          </Box>
        </Modal>
      </div>

      <div>
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
            <Button
              size="small"
              style={{
                backgroundColor: "crimson",
                color: "white",
                padding: "8px",
                marginTop: "10px",
              }}
              onClick={handleReject}
            >
              Reject
            </Button>
          </Box>
        </Modal>
      </div>
    </>
  );
}

// import React from "react";
// import axios from "axios";

// function nextChar(c) {
//   return String.fromCharCode(c.charCodeAt(0) + 1);
// }

// function prevChar(c) {
//   return String.fromCharCode(c.charCodeAt(0) - 1);
// }

// function Task({ title, task, id, position, status, date, time }) {
//   console.log(id);
//   function handleAccept() {
//     console.log("handleAccept");
//     axios
//       .post("http://localhost:5000/tasks/update/" + id, {
//         status: nextChar(position) === "E" ? "Accepted" : nextChar(position),
//       })
//       .then((res) => {
//         console.log(res.data);
//       })
//       .catch((err) => console.log(err));
//   }

//   function handleReject() {
//     console.log("handleReject");
//     axios
//       .post("http://localhost:5000/tasks/update/" + id, {
//         status: prevChar(position),
//       })
//       .then((res) => {
//         console.log(res.data);
//       })
//       .catch((err) => console.log(err));
//   }

//   return (
//     <div>
//       <div style={{ margin: "10px", border: "1px solid grey", padding: "5px" }}>
//         <p>Date and Time of Publishing: {date + " " + time}</p>
//         <h1>Title: {title}</h1>
//         <p>Task Description: {task}</p>
//         <p>Current Status: {status}</p>
//         <span style={{ display: "flex", marginTop: "8px" }}>
//           {position !== "A" ? (
//             <button
//               style={{
//                 border: "2px solid grey",
//                 padding: "3px",
//               }}
//               onClick={handleReject}
//             >
//               Reject
//             </button>
//           ) : (
//             <button
//               style={{
//                 border: "2px solid grey",
//                 padding: "3px",
//               }}
//               disabled="disabled"
//             >
//               Reject
//             </button>
//           )}

//           <button
//             style={{
//               marginLeft: "15px",
//               border: "2px solid grey",
//               padding: "3px",
//             }}
//             onClick={handleAccept}
//           >
//             Approve
//           </button>
//         </span>
//       </div>
//     </div>
//   );
// }

// export default Task;
