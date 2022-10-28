import React from "react";
import App from "./App";
import Register from "./Components/AdminRegister/Register";
import EmployeeCheckout from "./Components/EmployeeAdd/Checkout";
import ClientCheckout from "./Components/ClientAdd/Checkout";
// import { Redirect } from "react-router";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import AdminDashboard from "./Components/AdminDashboard/App";
import EmployeeList from "./Components/EmployeeList/EmployeeList";
import CreateTask from "./CreateTask";
import AllTasks from "./AllTasks";
import Navbar from "./Components/AdminDashboard/components/navbar/Navbar";
// import Sidebar from "./Components/AdminDashboard/components/sidebar/Sidebar";
import "./Components/AdminDashboard/App.css";
import TaskCard from "./Components/taskList/TaskCard";
import Questionairre from "./Components/ClientQuestionairre/Questionairre";
import ClientStatus from "./Components/ClientStatus/ClientStatus";
function Main() {
  // const [sidebar,setSidebar] = useState(false);

  // function toggleSidebar()
  // {
  //   setSidebar(!sidebar);
  // }

  return (
    <Router>
      <div>
        <Switch>
          <Route path="/" exact component={() => <App />} />
          <Route path="/admin/register" exact component={() => <Register />} />
          <div>
            <Navbar />
            <Route
              path="/dashboard"
              exact
              component={() => <AdminDashboard />}
            />
            <Route
              path="/employees/add"
              exact
              component={() => <EmployeeCheckout />}
            />
            <Route
              path="/questionairre"
              exact
              component={() => <Questionairre />}
            />
            <Route
              path="/clients/add"
              exact
              component={() => <ClientCheckout />}
            />
            <Route
              path="/tasks/create"
              exact
              component={() => <CreateTask />}
            />
            <Route
              path="/approvals"
              exact
              component={() => <AllTasks />}
            ></Route>
            <Route
              path="/approvals/taskcard/"
              exact
              component={() => <TaskCard />}
            />
            <Route
              path="/status/:company"
              exact
              component={() => <ClientStatus />}
            />
            <Route
              path="/employee/management"
              exact
              component={() => <EmployeeList />}
            />
            {/* <Sidebar /> */}
          </div>

          {/* </div> */}
        </Switch>
      </div>
    </Router>
  );
}

export default Main;
