import { dbank } from "../../declarations/dbank";

const checkBalance = async () => {
  const currentAmount = await dbank.checkBalance()
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}

window.addEventListener("load", checkBalance);

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();

  const button = document.getElementById("submit-btn");
  const topupAmount = document.getElementById("input-amount");
  const withdrawAmount = document.getElementById("withdrawal-amount");

  button.setAttribute("disabled",true);

  if(topupAmount.value.length != 0) {
    await dbank.topUp(parseFloat(topupAmount.value));
    topupAmount.value = "";
  }

  if(withdrawAmount.value.length != 0) {
    await dbank.withdraw(parseFloat(withdrawAmount.value));
    withdrawAmount.value = "";
  }

  await dbank.compound();

  checkBalance();

  button.removeAttribute("disabled");
})