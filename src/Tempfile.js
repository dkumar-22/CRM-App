export const positions = ["A", "B", "C", "D", "E"];

export function setLimit(amt) {
  if (amt <= 50000) return 3;
  else if (amt > 50000 && amt <= 100000) return 4;
  else if (amt > 100000) return 5;
  else return 5;
}
