import React, { useState, useEffect } from "react";
import axios from "axios";
// import Task from "./Task";
// import { useDataLayerValue } from "./DataLayer";
// import Grid from "@mui/material/Grid";
import TaskList from "./Components/taskList/TaskList";
import TaskListBar from "./Components/taskList/TaskListBar";

function AllTasks() {
  // const [{ position }] = useDataLayerValue();
  const [alltasks, setAllTasks] = useState([]);
  const [pendingtasks, setpendingTasks] = useState([]);
  const [approvedtasks, setapprovedTasks] = useState([]);
  const [disapprovedtasks, setdisapprovedTasks] = useState([]);
  const [val, setVal] = useState(0);
  console.log(val);
  useEffect(() => {
    axios
      .get("http://localhost:5000/tasks/all")
      .then((res) => {
        console.log(res.data);
        setAllTasks(res.data);
      })
      .catch((err) => {
        console.log(err);
      });
    axios
      .get("http://localhost:5000/tasks/pending")
      .then((res) => {
        console.log(res.data);
        setpendingTasks(res.data);
      })
      .catch((err) => {
        console.log(err);
      });
    axios
      .get("http://localhost:5000/tasks/approved")
      .then((res) => {
        console.log(res.data);
        setapprovedTasks(res.data);
      })
      .catch((err) => {
        console.log(err);
      });
    axios
      .get("http://localhost:5000/tasks/disapproved")
      .then((res) => {
        console.log(res.data);
        setdisapprovedTasks(res.data);
      })
      .catch((err) => {
        console.log(err);
      });
  }, []);

  function SwitchTask() {
    if (val === 0) return <TaskList tasks={alltasks} />;
    else if (val === 1) return <TaskList tasks={pendingtasks} />;
    else if (val === 2) return <TaskList tasks={approvedtasks} />;
    else if (val === 3) return <TaskList tasks={disapprovedtasks} />;
    else return <TaskList tasks={alltasks} />;
  }
  return (
    // <div style={{ padding: "20px" }}>
    //   <Grid container spacing={4}>
    //     {tasks.map(function (task) {
    //       return (
    //         <Grid item xs={4} key={i++}>
    //           <Task
    //             position={position}
    //             title={task.title}
    //             task={task.task}
    //             status={task.status}
    //             date={task.date}
    //             time={task.time}
    //             comments={task.comments}
    //             id={task._id}
    //           />
    //         </Grid>
    //       );
    //     })}
    //   </Grid>
    // </div>
    <div style={{ padding: "20px", marginLeft: "100px", marginRight: "100px" }}>
      <TaskListBar val={val} setVal={setVal} />
      <SwitchTask />
    </div>
  );
}

export default AllTasks;
