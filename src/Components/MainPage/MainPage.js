import React, { useState } from "react";
import MainPageLeft from "./MainPageLeft/MainPageLeft";
import MainPageRight from "./MainPageRight/MainPageRight";
import SignIn from "./MainPageRight/SignIn";
function MainPage() {
  // function sayHello() {
  //   alert("You clicked me!");
  // }

  const [clicked, setClicked] = useState(false);

  return (
    <div className="md:flex md:flex-wrap h-screen">
      <div className="w-1/2 text-center bg-offwhite leftArea">
        <MainPageLeft />
      </div>
      <div className="w-1/2 text-center">
        {!clicked ? (
          <MainPageRight clicked={clicked} setClicked={setClicked} />
        ) : (
          <SignIn clicked={clicked} setClicked={setClicked} />
        )}
      </div>
    </div>
  );
}

export default MainPage;
