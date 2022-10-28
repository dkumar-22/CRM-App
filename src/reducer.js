export const initialState = {
  id: "",
  position: "",
  logged: false,
  username: "",
  approvalsCount: 0,
};

function reducer(state, action) {
  console.log("🕺", action);
  switch (action.type) {
    case "SET_USER":
      return {
        ...state,
        username: action.username,
      };
    case "SET_APPROVALSCOUNT":
      return {
        ...state,
        approvalsCount: action.approvalsCount,
      };
    case "SET_ID":
      return {
        ...state,
        id: action.id,
      };
    case "SET_POSITION":
      return {
        ...state,
        position: action.position,
      };
    case "SET_LOGGED":
      return {
        ...state,
        logged: action.logged,
      };
    default:
      return state;
  }
}

export default reducer;
