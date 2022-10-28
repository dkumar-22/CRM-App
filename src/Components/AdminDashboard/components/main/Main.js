import React from "react";
import "./Main.css";
import hello from "../../assets/hello.svg";
import Chart from "../charts/Chart";
import { Link } from "react-router-dom";
// import SendIcon from "@mui/icons-material/Send";
// import Button from "@mui/material/Button";
import { useDataLayerValue } from "../../../../DataLayer";
const linkstyle = {
  textDecoration: "none",
};

const Main = () => {
  const [{ username, approvalsCount }] = useDataLayerValue();
  return (
    <main>
      <div className="main__container">
        {/* <!-- MAIN TITLE STARTS HERE --> */}
        <div className="top_container">
          <div className="main__title">
            <img src={hello} alt="hello" />
            <div className="main__greeting">
              <h1>Welcome {username}</h1>
              <p>Dashboard</p>
            </div>
          </div>
          <div></div>
        </div>

        {/* <!-- MAIN TITLE ENDS HERE --> */}

        {/* <!-- MAIN CARDS STARTS HERE --> */}
        <div className="main__cards">
          <div className="card">
            <i
              className="fa fa-user-o fa-2x text-lightblue"
              aria-hidden="true"
            ></i>
            <div className="card_inner">
              <p className="text-primary-p">Number of Clients</p>
              <span className="font-bold text-title">578</span>
            </div>
          </div>
          <Link to={"/approvals"} style={linkstyle}>
            <div className="card">
              <i
                className="fa fa-calendar fa-2x text-red"
                aria-hidden="true"
              ></i>
              <div className="card_inner">
                <p className="text-primary-p">View Approvals</p>
                <span className="font-bold text-title">{approvalsCount}</span>
              </div>
            </div>
          </Link>
          <div className="card">
            <i
              className="fa fa-video-camera fa-2x text-yellow"
              aria-hidden="true"
            ></i>
            <div className="card_inner">
              <p className="text-primary-p">Active Clients</p>
              <span className="font-bold text-title">340</span>
            </div>
          </div>

          <div className="card">
            <i
              className="fa fa-thumbs-up fa-2x text-green"
              aria-hidden="true"
            ></i>
            <div className="card_inner">
              <p className="text-primary-p">Active Employees</p>
              <span className="font-bold text-title">645</span>
            </div>
          </div>
        </div>
        {/* <!-- MAIN CARDS ENDS HERE --> */}

        {/* <!-- CHARTS STARTS HERE --> */}
        <div className="charts">
          <div className="charts__left">
            <div className="charts__left__title">
              <div>
                <h1>Daily Reports</h1>
                <p></p>
              </div>
              <i className="fa fa-usd" aria-hidden="true"></i>
            </div>
            <Chart />
          </div>

          <div className="charts__right">
            <div className="charts__right__title">
              <div>
                <h1>Stats Reports</h1>
                <p></p>
              </div>
              <i className="fa fa-usd" aria-hidden="true"></i>
            </div>

            <div className="charts__right__cards">
              <div className="card1">
                <h1>Income</h1>
                <p>$75,300</p>
              </div>

              <div className="card2">
                <h1>Sales</h1>
                <p>$124,200</p>
              </div>

              <div className="card3">
                <h1>Users</h1>
                <p>3900</p>
              </div>

              <div className="card4">
                <h1>Orders</h1>
                <p>1881</p>
              </div>
            </div>
          </div>
        </div>
        {/* <!-- CHARTS ENDS HERE --> */}
      </div>
    </main>
  );
};

export default Main;
