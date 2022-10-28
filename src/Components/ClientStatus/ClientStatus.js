import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";
import "./styles.css";

function ClientStatus() {
  let { company } = useParams();
  const [status, setStatus] = useState(false);
  const [compName, setCompName] = useState("");
  useEffect(() => {
    axios
      .get("http://localhost:5000/tasks/status/" + company)
      .then((res) => {
        setStatus(res.data.status);
        setCompName(res.data.companyName);
      })
      .catch((err) => console.log(err));
  }, [company]);

  console.log(status);

  if (status === false) {
    return (
      <div className="status-info">
        <h1>Current Status for {company}: In Progress</h1>
        <h4>Please Wait until your credentials get approved</h4>
      </div>
    );
  } else {
    return (
      <div className="status-info">
        <h3>Current Status for {compName}: Completed</h3>
        <br />
        <a href={"http://localhost:5000/word/" + company}>
          <button className="btndownload">Click Here to Download Report</button>
        </a>
      </div>
    );
  }
}

export default ClientStatus;
