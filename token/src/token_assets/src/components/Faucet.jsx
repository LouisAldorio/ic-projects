import React from "react";
import { token } from "../../../declarations/token";

function Faucet() {

  const [isDisabled, setIsDisabled] = React.useState(false);
  const [text, setText] = React.useState("Gimme gimme");

  async function handleClick(event) {
    setIsDisabled(true);

    const result = await token.payOut();
    setText(result);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free DAngela tokens here! Claim 10,000 DANG coins to your account.</label>
      <p className="trade-buttons">
        <button disabled={isDisabled} id="btn-payout" onClick={handleClick}>
          {text}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
