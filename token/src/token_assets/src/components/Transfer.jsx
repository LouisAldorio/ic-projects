import React from "react";
import { Principal } from "@dfinity/principal"
import { token } from "../../../declarations/token"

function Transfer() {

  const [principalID, setPrincipalID] = React.useState("");
  const [amount, setAmount] = React.useState("");
  const [isDisabled, setIsDisabled] = React.useState(false);
  const [isHidden, setIsHidden] = React.useState(true);
  const [transferResult, setTransferResult] = React.useState("");
  
  async function handleClick() {
    setIsDisabled(true);
    const principal = Principal.fromText(principalID)
    const amountToSend = Number(amount)

    const result = await token.transfer(principal, amountToSend)
    setTransferResult(result)
    setIsHidden(false);
    setIsDisabled(false);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={principalID}
                onChange={(e) => setPrincipalID(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <p hidden={isHidden}>{transferResult}</p>
        <p className="trade-buttons">
          <button disabled={isDisabled} id="btn-transfer" onClick={handleClick} >
            Transfer
          </button>
        </p>
      </div>
    </div>
  );
}

export default Transfer;
