import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

actor Token {

    let owner : Principal = Principal.fromText("c53z5-swasz-ztuhd-ernwo-bdnlr-sk246-wh2pb-r3cmt-26e4c-2fntq-qae");
    let supply : Nat = 1000000000;
    let symbol : Text = "LOU";

    private stable var balanceEntries : [(Principal,Nat)] = [];

    private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    if (balances.size() < 1) {
        balances.put(owner, supply)
    };

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
            let result = await transfer(msg.caller, amount);

            return result;
        };

        return "Already Claimed";
    };

    public shared(msg) func transfer(to : Principal, amount : Nat) : async Text {
        let fromBalance = await balanceOf(msg.caller);
        if (fromBalance > amount) {

            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = await balanceOf(to);
            let newToBalance : Nat = toBalance + amount;
            balances.put(to, newToBalance);

            return "Success";
        };

        return "Insufficient Funds";
    };

    // pre and post upgrade
    system func preupgrade() {
        balanceEntries := Iter.toArray(balances.entries());
    };

    system func postupgrade() {
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);
        if (balances.size() < 1) {
            balances.put(owner, supply)
        }
    }
}