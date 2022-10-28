import React from "react";
// import { useState } from "react";
import "./App.css";
import Main from "./components/main/Main";
// import Navbar from "./components/navbar/Navbar";
// import Sidebar from "./components/sidebar/Sidebar";

const App = () => {
  // const [sidebarOpen, setsidebarOpen] = useState(false);
  // const openSidebar = () => {
  //   setsidebarOpen(true);
  // };
  // const closeSidebar = () => {
  //   setsidebarOpen(false);
  // };
  return (
    <>
      {/* <Navbar sidebarOpen={sidebarOpen} openSidebar={openSidebar} /> */}
      <Main />
      {/* <Sidebar sidebarOpen={sidebarOpen} closeSidebar={closeSidebar} /> */}
    </>
  );
};

export default App;
