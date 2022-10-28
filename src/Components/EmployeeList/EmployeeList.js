import React, { useEffect, useState } from "react";
// import { DataGrid } from "@mui/x-data-grid";
import axios from "axios";

function EmployeeList() {
  const [employees, setEmployees] = useState([]);
  useEffect(() => {
    axios
      .get("http://localhost:5000/employee/all")
      .then((res) => {
        setEmployees(res.data);
      })
      .catch((err) => {
        console.log(err);
      });
  }, []);
  console.log(employees);
  return (
    employees.map((employee) => {
      return (
        <div style={{display: "flex"}}>
          <h1>{employee.fname+" "+employee.lname}</h1>
          <p>{employee.email}</p>
          <p>{employee.phone}</p>
        </div>
      );
    }))
}

export default EmployeeList;
