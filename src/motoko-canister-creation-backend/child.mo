import Management "ic:aaaaa-aa";
import Cycles "mo:core/Cycles";
import Principal "mo:core/Principal";
shared persistent actor class Child() = this {
  public func cycleBalance() : async Nat {
    return Cycles.balance();
  };

  public func getCanisterStatus() : async Management.canister_status_result {
    return await Management.canister_status({
      canister_id = Principal.fromActor(this);
    });
  };
};
