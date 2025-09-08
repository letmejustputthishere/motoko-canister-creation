import Cycles "mo:core/Cycles";
shared persistent actor class Child() {
  public func cycleBalance() : async Nat {
    return Cycles.balance();
  };
};
