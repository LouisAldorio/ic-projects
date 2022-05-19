import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

actor Token {

    var owner : Principal = Principal.fromText("c53z5-swasz-ztuhd-ernwo-bdnlr-sk246-wh2pb-r3cmt-26e4c-2fntq-qae");
    var supply : Nat = 1000000000;
    var symbol : Text = "LOU";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(owner, supply);

    public query func balanceOf(address : Principal) : async Nat {
        
        let balance = switch (balances.get(address)) {
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSymbol() : async Text {
        return symbol;
    };

    public shared(msg) func payOut() : async Text {
        Debug.print(debug_show(msg.caller));

        let amount = 10000;
        if(balances.get(msg.caller) == null) {
            balances.put(owner, supply - amount);
            balances.put(msg.caller, amount);

            return "Success";
        };

        return "Already Claimed";
    }
}