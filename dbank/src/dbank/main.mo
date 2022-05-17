import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";
// Data Type
// Nat = Natural Number (Positive Number)
// Text = String

// actor is equal to class in other programming language
actor DBank {
    // stable var currentValue : Nat = 300; -> making the variable persistent accross every deploy (stable keyword)

    var currentValue : Float = 30;
    // assign to variable
    // currentValue := 50;

    // let act like const (immutable)
    let id = 1231342135131;

    // same like console.log in javascript
    // debug_show is required to convert any value type Text
    // Debug.print(debug_show(id));

    // by default function is private to this class/actor
    // add public modifier to make function public
    public func topUp(amount : Float) {
        currentValue += amount;
        Debug.print(debug_show(currentValue));
    };

    // topUp();

    // withdrawal function
    public func withdraw(amount : Float) {
        let tempValue : Float = currentValue - amount;

        if (tempValue >= 0) {
            currentValue -= amount;
            Debug.print(debug_show(currentValue));
        }else {
            Debug.print("Insufficient Balance");
        }
    };

    // query function must be async return
    public query func checkBalance() : async Float {
        return currentValue;
    };


    var startTime = Time.now();
    // calculate compound interest persecond
    public func compound() {
        let currentTime = Time.now();
        let timeElapsedNS = currentTime - startTime;
        let timeElapsedS = timeElapsedNS / 1000000000;
        currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
        startTime := currentTime;
    };
}

// Command to use Candid UI , similiar to Swagger for API Documentation
// dfx canister id __Candid_UI -> output the CanisterId for th Candid UI
// http://127.0.0.1:8000/?canisterId=<Candid UI CanisterId>
// dfx canister id <Canister name> -> dbank (get the dbank canister Id)

// dfx start --emulator --clean