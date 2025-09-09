dfx stop
dfx start --clean --background
dfx deploy --with-cycles 10_000_000_000_000   
dfx canister call motoko-canister-creation-backend createCanisterWithPrim 900_000_000_000
dfx canister call motoko-canister-creation-backend createCanisterWithPrim 800_000_000_000
dfx canister call motoko-canister-creation-backend createCanisterFromActorClass 900_000_000_000
dfx canister call motoko-canister-creation-backend createCanisterFromActorClass 800_000_000_000