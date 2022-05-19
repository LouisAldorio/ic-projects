import React from "react";
import { Principal } from "@dfinity/principal"
import { token } from "../../../declarations/token"

function Balance() {

  const [principalID, setPrincipalID] = React.useState("");
  const [balanceResult, setBalanceResult] = React.useState("");
  
  async function handleClick() {
    const principal = Principal.fromText(principalID)
    const balance = await token.balanceOf(principal)
    const symbol = await token.getSymbol()

    setBalanceResult(`${balance} ${symbol}`)
  }

  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          id="balance-principal-id"
          type="text"
          placeholder="Enter a Principal ID"
          value={principalID}
          onChange={(e) => setPrincipalID(e.target.value)}
        />
      </p>
      <p className="trade-buttons">
        <button
          id="btn-request-balance"
          onClick={handleClick}
        >
          Check Balance
        </button>
      </p>
      <p hidden={balanceResult === ""}>This account has a balance of {balanceResult}.</p>
    </div>
  );
}

export default Balance;
