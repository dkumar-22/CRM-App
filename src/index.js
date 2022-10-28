import React from "react";
import ReactDOM from "react-dom/client";
import Main from "./Main";
import * as serviceWorker from "./serviceWorker";
import { DataLayer } from "./DataLayer";
import "./styles/index.css";
import reducer, { initialState } from "./reducer";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <DataLayer initialState={initialState} reducer={reducer}>
    <Main />
  </DataLayer>
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
