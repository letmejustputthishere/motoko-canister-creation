import Child "child";
import Principal "mo:core/Principal";
import Debug "mo:core/Debug";
import Management "ic:aaaaa-aa";

persistent actor Main {

  public shared ({ caller }) func createCanisterFromActorClass(cycles : Nat) : async Principal {
    let settings = {
      settings = ?{
        controllers = ?[caller, Principal.fromActor(Main)];
        compute_allocation = null;
        freezing_threshold = null;
        memory_allocation = null;
      };
    };
    let canister = await (with cycles) (system Child.Child)(#new settings)();
    return Principal.fromActor(canister);
  };

  public shared ({ caller }) func createCanisterManually(cycles : Nat) : async Principal {
    let canisterId = await createCanisterWithCycles(caller, cycles);
    await installCode(canisterId);
    return canisterId;
  };

  public shared ({ caller }) func createAndInstallCanisterInlined(cycles : Nat) : async () {
    await Management.install_code({
      canister_id = do {
        let _result = await (with cycles) Management.create_canister({
          sender_canister_version = null;
          settings = ?{
            log_visibility = null;
            reserved_cycles_limit = null;
            compute_allocation = null;
            memory_allocation = null;
            controllers = ?[caller, Principal.fromActor(Main)];
            freezing_threshold = null;
            wasm_memory_limit = null;
            wasm_memory_threshold = null;
          };
        });
        Debug.print(debug_show (_result));
        _result.canister_id;
      };
      mode = #install;
      wasm_module : Blob = "\00\61\73\6d\01\00\00\00";
      arg : Blob = "";
      sender_canister_version = null;
    });
  };

  public func createCanisterWithCycles(caller : Principal, cycles : Nat) : async Principal {
    let _result = await (with cycles) Management.create_canister({
      sender_canister_version = null;
      settings = ?{
        log_visibility = null;
        reserved_cycles_limit = null;
        compute_allocation = null;
        memory_allocation = null;
        controllers = ?[caller, Principal.fromActor(Main)];
        freezing_threshold = null;
        wasm_memory_limit = null;
        wasm_memory_threshold = null;
      };
    });
    return _result.canister_id;
  };

  public func installCode(canisterId : Principal) : async () {
    await Management.install_code({
      canister_id = canisterId;
      mode = #install;
      wasm_module : Blob = "\00\61\73\6d\01\00\00\00";
      arg : Blob = "";
      sender_canister_version = null;
    });
  };
};
