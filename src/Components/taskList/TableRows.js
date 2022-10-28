import React, { useState } from "react";
import TableRow from "@mui/material/TableRow";
import TableCell from "@mui/material/TableCell";
import OpenInFullIcon from "@mui/icons-material/OpenInFull";
import axios from "axios";
import { useDataLayerValue } from "../../DataLayer";
import Dialog from "@mui/material/Dialog";
import ApproveModal from "./ApproveModal";
import RejectModal from "./RejectModal";
import DisapproveModal from "./DisapproveModal";
import { positions } from "../../Tempfile";
import { DialogContent, DialogContentText, DialogTitle } from "@mui/material";
// const style = {
//   position: "absolute",
//   top: "50%",
//   left: "50%",
//   transform: "translate(-50%, -50%)",
//   width: 400,
//   bgcolor: "background.paper",
//   border: "2px solid #000",
//   boxShadow: 24,
//   p: 4,
// };

function TableRows({
  id,
  title,
  date,
  time,
  addedBy,
  task,
  comments,
  status,
  amount,
  type,
  maxLimit,
  clientInfo,
  nameID,
}) {
  console.log(maxLimit);
  const [{ position, username }] = useDataLayerValue();

  function nextPos(c) {
    const str = parseInt(c) + 1;
    return str === maxLimit ? "Accepted" : String(str);
  }

  // console.log(nextPos("1"));
  // function prevChar(c) {
  //   return String.fromCharCode(c.charCodeAt(0) - 1);
  // }

  const [openModal, setModalOpen] = React.useState(false);
  const handleModalOpen = () => setModalOpen(true);
  const handleModalClose = () => setModalOpen(false);

  const [openModal2, setModal2Open] = React.useState(false);
  const handleModal2Open = () => setModal2Open(true);
  const handleModal2Close = () => setModal2Open(false);

  const [acceptOpen, setAcceptOpen] = React.useState(false);
  const handleAcceptOpen = () => setAcceptOpen(true);
  const handleAcceptClose = () => setAcceptOpen(false);

  const [rejectOpen, setRejectOpen] = React.useState(false);
  const handleRejectOpen = () => setRejectOpen(true);
  const handleRejectClose = () => setRejectOpen(false);

  const [disapproveOpen, setdisapproveOpen] = React.useState(false);
  const handledisapproveOpen = () => setdisapproveOpen(true);
  const handledisapproveClose = () => setdisapproveOpen(false);

  const [currcomments, setcurrComments] = useState("");
  // const [updated, setUpdated] = useState(false);

  const [rbStatus, setRbStatus] = useState("");

  function handleRbStatus(e) {
    setRbStatus(e.target.value);
    console.log(rbStatus);
  }

  function handleChange(e) {
    setcurrComments(e.target.value);
  }

  function handleAccept() {
    const commentObj = {
      addedBy: username,
      prevStatus: status,
      commentVal: currcomments,
    };
    axios
      .post("http://localhost:5000/tasks/update/" + id, {
        status: nextPos(status),
        comments: [...comments, commentObj],
      })
      .then((res) => {
        console.log(res.data);
        // setUpdated(true);
      })
      .catch((err) => console.log(err));
  }

  function handleReject() {
    const commentObj = {
      addedBy: username,
      prevStatus: status,
      commentVal: currcomments,
    };
    axios
      .post("http://localhost:5000/tasks/update/" + id, {
        status: rbStatus,
        comments: [...comments, commentObj],
      })
      .then((res) => {
        console.log(res.data);
        // setUpdated(true);
      })
      .catch((err) => console.log(err));
  }

  function handledisapprove() {
    const commentObj = {
      addedBy: username,
      prevStatus: status,
      commentVal: currcomments,
    };
    axios
      .post("http://localhost:5000/tasks/update/" + id, {
        status: "Disapproved",
        comments: [...comments, commentObj],
      })
      .then((res) => {
        console.log(res.data);
        // setUpdated(true);
      })
      .catch((err) => console.log(err));
  }
  return (
    <TableRow
      key={id}
      sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
    >
      <TableCell component="th" scope="row">
        {date + " " + time}
      </TableCell>
      <TableCell>{addedBy}</TableCell>
      <TableCell>{title}</TableCell>
      <TableCell align="center">{task}</TableCell>
      <TableCell align="center">{type}</TableCell>
      <TableCell align="center">
        {amount === undefined ? "-" : amount}
      </TableCell>

      <TableCell align="center">
        {clientInfo === undefined ? (
          "-"
        ) : (
          <button onClick={handleModal2Open}>
            <OpenInFullIcon fontSize="small" />
          </button>
        )}
        {clientInfo !== undefined && (
          <Dialog
            open={openModal2}
            onClose={handleModal2Close}
            fullWidth
            scroll="paper"
            maxWidth="sm"
            aria-labelledby="alert-dialog-title"
            aria-describedby="alert-dialog-description"
          >
            <DialogTitle id="alert-dialog-title">
              Client Responses:{" "}
            </DialogTitle>
            <DialogContent>
              <br />
              <DialogContentText>
                {"Company Name: " + clientInfo.companyName}
              </DialogContentText>
              <DialogContentText>{"CEO: " + clientInfo.CEO}</DialogContentText>
              <DialogContentText>{"CTO: " + clientInfo.CTO}</DialogContentText>
              <DialogContentText>
                {"Issue Date: " + clientInfo.issueDate}
              </DialogContentText>
              <DialogContentText>
                {"Review Date: " + clientInfo.reviewDate}
              </DialogContentText>
              <DialogContentText>
                {"Next Review Date: " + clientInfo.nextReviewDate}
              </DialogContentText>
              <DialogContentText>
                {"Version: " + clientInfo.version}
              </DialogContentText>
              <DialogContentText>
                {"Approver Name: " + clientInfo.approverName}
              </DialogContentText>
              <DialogContentText>
                {"Approver Designation: " + clientInfo.approverDesignation}
              </DialogContentText>
              <DialogContentText>
                {"Reviewer Name: " + clientInfo.reviewerName}
              </DialogContentText>
              <DialogContentText>
                {"Reviewer Designation: " + clientInfo.reviewerDesignation}
              </DialogContentText>
              <DialogContentText>
                {"IT Head Name: " + clientInfo.ITHeadName}
              </DialogContentText>
              <DialogContentText>
                {"IT Head Designation: " + clientInfo.ITHeadDesignation}
              </DialogContentText>
              <DialogContentText>
                {"Security Manager Name: " + clientInfo.SecurityManagerName}
              </DialogContentText>
              <DialogContentText>
                {"Security Manager Designation: " +
                  clientInfo.SecurityManagerDesignation}
              </DialogContentText>
              <DialogContentText>
                {"Security Compliance Committee: " +
                  clientInfo.SecurityComplianceCommittee}
              </DialogContentText>
              <DialogContentText>
                {"Contact Authorities: " + clientInfo.ContactAuthorities}
              </DialogContentText>
              <DialogContentText>
                {"Incident Handling Mail: " + clientInfo.incidentHandlingMail}
              </DialogContentText>
              <DialogContentText>
                {"Designation Of Security Head: " +
                  clientInfo.designationOfSecurityHead}
              </DialogContentText>
              <DialogContentText>
                {"Name Of Security Head: " + clientInfo.nameOfSecurityHead}
              </DialogContentText>
              <DialogContentText>
                {"Prepared By: " + clientInfo.preparedBy}
              </DialogContentText>
              <DialogContentText>
                <a href={"http://localhost:5000/word/" + nameID}>
                  <button className="btndownload">
                    Click Here to Download Report
                  </button>
                </a>
              </DialogContentText>
            </DialogContent>
          </Dialog>
        )}
      </TableCell>

      <TableCell align="center">
        {comments.length === 0
          ? "-"
          : "Added By: " +
            comments[comments.length - 1].addedBy +
            ", " +
            "Previous Status: " +
            positions[parseInt(comments[comments.length - 1].prevStatus)] +
            ", " +
            "Comment: " +
            comments[comments.length - 1].commentVal}
      </TableCell>
      <TableCell align="center">
        <button onClick={handleModalOpen}>
          <OpenInFullIcon fontSize="small" />
        </button>
        <Dialog
          open={openModal}
          onClose={handleModalClose}
          fullWidth
          scroll="paper"
          maxWidth="sm"
          aria-labelledby="alert-dialog-title"
          aria-describedby="alert-dialog-description"
        >
          <DialogTitle id="alert-dialog-title">Previous Comments: </DialogTitle>
          <DialogContent>
            <br />
            {comments !== undefined &&
              comments.map(function (comment, index) {
                return (
                  index < comments.length - 1 && (
                    <DialogContentText key={title}>
                      {"Added By: " + comment.addedBy}
                      <br />
                      {"Previous Status: " +
                        positions[parseInt(comment.prevStatus)]}
                      <br />
                      {"Comment: " + comment.commentVal}
                      <br />
                      <br />
                    </DialogContentText>
                  )
                );
              })}
          </DialogContent>
        </Dialog>
      </TableCell>
      {status === "Accepted" || status === "Disapproved" ? (
        <TableCell align="center">{status}</TableCell>
      ) : (
        <TableCell align="center">{positions[parseInt(status)]}</TableCell>
      )}
      {/* && status === position */}
      <TableCell align="left">
        {status !== "Disapproved" && status !== "Accepted" ? (
          <>
            <button
              style={{
                display: "block",
                color: "green",
                border: "1px solid green",
                padding: "4px",
                margin: "4px",
                borderRadius: "4px",
              }}
              onClick={handleAcceptOpen}
            >
              Approve
            </button>
            <button
              style={{
                display: "block",
                border: "1px solid black",
                padding: "4px",
                margin: "4px",
                borderRadius: "6px",
              }}
              onClick={handleRejectOpen}
            >
              Refer Back
            </button>
            <button
              style={{
                color: "red",
                border: "1px solid red",
                display: "block",
                padding: "4px",
                margin: "4px",
                borderRadius: "6px",
              }}
              onClick={handledisapproveOpen}
            >
              Disapprove
            </button>{" "}
          </>
        ) : (
          "No Action Required"
        )}

        <ApproveModal
          handleAccept={handleAccept}
          acceptOpen={acceptOpen}
          handleAcceptClose={handleAcceptClose}
          handleChange={handleChange}
          currcomments={currcomments}
        />
        <RejectModal
          status={status}
          rejectOpen={rejectOpen}
          handleRejectClose={handleRejectClose}
          handleChange={handleChange}
          currcomments={currcomments}
          handleRbStatus={handleRbStatus}
          rbStatus={rbStatus}
          handleReject={handleReject}
          type={type}
        />
        <DisapproveModal
          id={id}
          status={status}
          handledisapprove={handledisapprove}
          disapproveOpen={disapproveOpen}
          handledisapproveClose={handledisapproveClose}
          handleChange={handleChange}
          currcomments={currcomments}
        />
      </TableCell>
    </TableRow>
  );
}

export default TableRows;
