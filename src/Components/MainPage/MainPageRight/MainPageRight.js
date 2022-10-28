import React from "react";
import "../MainPage.css"
const MainPageRight = ({clicked,setClicked}) => {
    function sayHello() {
        setClicked(!clicked);
      }
  return (
    <>
      <div >
        <div className="grid grid-flow-row auto-rows-max md:auto-rows-min">
          <ul className="buttonBox">
            <li className="buttonBlock">
              <button style={{"backgroundColor":"black"}} className="loginButton" onClick={sayHello}>
                Login as Admin
              </button>
            </li>
            <li className="buttonBlock">
              <button style={{"backgroundColor":"purple"}} className="loginButton" onClick={sayHello}>
                Login as Employee
              </button>
            </li>
            <li className="buttonBlock">
              <button style={{"backgroundColor":"navy"}} className="loginButton" onClick={sayHello}>
                Login as Client
              </button>
            </li>
          </ul>
        </div>
      </div>
    </>
  );
};

export default MainPageRight;
