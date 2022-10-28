import React from "react";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import { makeStyles } from "@mui/styles";
import { setLimit } from "../../Tempfile";
// import axios from "axios";
// import Typography from "@mui/material/Typography";
// import OpenInFullIcon from "@mui/icons-material/OpenInFull";
// import Box from "@mui/material/Box";
// import Modal from "@mui/material/Modal";
// // import Button from "@mui/material/Button";
// // import TextField from "@mui/material/TextField";
import TableRows from "./TableRows";

const useStyles = makeStyles({
  root: {
    background: "",
    border: 0,
    borderRadius: 3,
    overflow: "scroll",
    // boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    color: "white",
    padding: "0 30px",
  },
});

const TaskList = ({ tasks }) => {
  const classes = useStyles();
  console.log(tasks);
  return (
    <TableContainer component={Paper} className={classes.root}>
      <Table aria-label="a dense table">
        <TableHead>
          <TableRow>
            <TableCell>Date & Time</TableCell>
            <TableCell>Added By</TableCell>
            <TableCell>Task Name</TableCell>
            <TableCell align="center">View Task Description</TableCell>
            <TableCell align="center">Type</TableCell>
            <TableCell align="center">Amount</TableCell>
            <TableCell align="center">Client Responses</TableCell>
            <TableCell align="center">Last Comment</TableCell>
            <TableCell align="center">View Previous Comments</TableCell>
            <TableCell align="center">Current Status</TableCell>
            <TableCell align="left">Actions</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {tasks.map((row) => {
            return (
              <TableRows
                key={row._id}
                id={row._id}
                title={row.title}
                comments={row.comments}
                addedBy={row.addedBy}
                task={row.task}
                status={row.status}
                date={row.date}
                time={row.time}
                type={row.type}
                amount={row.amount}
                maxLimit={setLimit(row.amount)}
                clientInfo={row.clientInfo}
                nameID={row.nameID}
              />
            );
          })}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default TaskList;
