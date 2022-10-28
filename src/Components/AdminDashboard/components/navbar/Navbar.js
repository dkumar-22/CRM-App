import React from "react";
import "./Navbar.css";
import avatar from "../../assets/avatar.svg";
import Box from "@mui/material/Box";
import Drawer from "@mui/material/Drawer";
import List from "@mui/material/List";
import Divider from "@mui/material/Divider";
import ListItem from "@mui/material/ListItem";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
import InboxIcon from "@mui/icons-material/MoveToInbox";
import MenuIcon from "@mui/icons-material/Menu";
import DashboardIcon from "@mui/icons-material/Dashboard";
import BadgeIcon from "@mui/icons-material/Badge";
import ApprovalIcon from "@mui/icons-material/Approval";
import AddTaskIcon from "@mui/icons-material/AddTask";
import { Link } from "react-router-dom";
import AddIcon from "@mui/icons-material/Add";
import logo from "../../assets/logo.png";

const Navbar = () => {
  const linkstyle = {
    textDecoration: "none",
  };
  const [state, setState] = React.useState({
    left: false,
  });

  const toggleDrawer = (anchor, open) => (event) => {
    if (
      event.type === "keydown" &&
      (event.key === "Tab" || event.key === "Shift")
    ) {
      return;
    }

    setState({ ...state, [anchor]: open });
  };

  const list = (anchor) => (
    <Box
      sx={{ width: anchor === "top" || anchor === "bottom" ? "auto" : 250 }}
      role="presentation"
      onClick={toggleDrawer(anchor, false)}
      onKeyDown={toggleDrawer(anchor, false)}
    >
      <List>
        {[
          { text: "Dashboard", icon: <DashboardIcon />, link: "/dashboard" },
          {
            text: "Employees",
            icon: <BadgeIcon />,
            link: "/employee/management",
          },
          { text: "Clients", icon: <InboxIcon />, link: "/clients/management" },
          { text: "Approvals", icon: <ApprovalIcon />, link: "/approvals" },
        ].map((data, index) => (
          <Link key={data.text} to={data.link} style={linkstyle}>
            <ListItem disablePadding>
              <ListItemButton>
                <ListItemIcon>{data.icon}</ListItemIcon>
                <ListItemText primary={data.text} />
              </ListItemButton>
            </ListItem>
          </Link>
        ))}
      </List>
      <Divider />
      <List>
        {[
          { text: "Leaves", icon: <ApprovalIcon />, link: "/leaves" },
          { text: "Create Task", icon: <AddTaskIcon />, link: "/tasks/create" },
        ].map((data, index) => (
          <Link key={data.text} to={data.link} style={linkstyle}>
            <ListItem disablePadding>
              <ListItemButton>
                <ListItemIcon>{data.icon}</ListItemIcon>
                <ListItemText primary={data.text} />
              </ListItemButton>
            </ListItem>
          </Link>
        ))}
      </List>
      <Divider />
      <List>
        {[
          { text: "Add Employee", icon: <AddIcon />, link: "/employees/add" },
          { text: "Add Client", icon: <AddIcon />, link: "/clients/add" },
        ].map((data, index) => (
          <Link key={data.text} to={data.link} style={linkstyle}>
            <ListItem disablePadding>
              <ListItemButton>
                <ListItemIcon>{data.icon}</ListItemIcon>
                <ListItemText primary={data.text} />
              </ListItemButton>
            </ListItem>
          </Link>
        ))}
      </List>
    </Box>
  );
  return (
    <nav className="navbar">
      <div className="navbar__left" style={{ display: "flex" }}>
        <React.Fragment>
          <MenuIcon
            style={{
              color: "black",
              border: "none",
              outline: "none",
              cursor: "pointer",
            }}
            onClick={toggleDrawer("left", true)}
          />
          <Drawer
            anchor={"left"}
            open={state["left"]}
            onClose={toggleDrawer("left", false)}
          >
            {list("left")}
          </Drawer>
        </React.Fragment>
        <Link to="/dashboard">
          <div className="logo">
            <img
              src={logo}
              alt="logo"
              style={{
                objectFit: "contain",
                width: "40px",
                marginRight: "8px",
                marginLeft: "8px",
              }}
            />
            <h1 className="logo-name">Aumyaa</h1>
          </div>
        </Link>
      </div>
      <div className="navbar__right">
        {/* <a href="/">
          <i className="fa fa-search" aria-hidden="true"></i>
        </a>
        <a href="/">
          <i className="fa fa-clock-o" aria-hidden="true"></i>
        </a> */}
        <a href="/">
          <img width="30" src={avatar} alt="avatar" />
        </a>
      </div>
    </nav>
  );
};

export default Navbar;
