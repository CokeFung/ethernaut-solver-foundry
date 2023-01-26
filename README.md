# Ethernaut Solver (Foundry)

## Unsolved Temaplate
TBD

## Note

### Install
trust the docs: https://book.getfoundry.sh/getting-started/installation

### setup environment for executing
1. create and update the `.env` file
2. run `source .env`
3. now you can use `$FOUNDRY_PRIVATE_KEY` and `$FOUNDRY_GOERLI_RPC_URL` in command-line

### adding new level
1. create new directory in `src` and new contract file in it (core contract should match the contract file)
2. run `python3 create-template.py`
3. done

### example command
- executing on local network
    ```
    forge script script/SOLVERTEMPLATE/SOLVERTEMPLATE.s.sol
    ```
- executing on specified network (If it fails, try `source .env` first)
    ```
    forge script script/SOLVERTEMPLATE/SOLVERTEMPLATE.s.sol \
    --rpc-url $FOUNDRY_GOERLI_RPC_URL \
    --private-key $FOUNDRY_PRIVATE_KEY \
    --broadcast
    ```

### solutions
- [x]  [Hello Ethernaut](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/hello-ethernaut)
- [x]  [Fallback](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/fallback)
- [x]  [Fallout](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/fallout)
- [x]  [Coin Flip](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/coin-flip)
- [x]  [Telephone](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/telephone)
- [x]  [Token](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/token)
- [x]  [Delegation](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/delegation)
- [x]  [Force](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/force)
- [x]  [Vault](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/vault)
- [x]  [King](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/king)
- [x]  [Re-entrancy](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/re-entrancy)
- [x]  [Elevator](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/elevator)
- [x]  [Privacy](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/privacy)
- [x]  [Gatekeeper One](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/gatekeeper-one)
- [x]  [Gatekepper Two](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/gatekeeper-two)
- [x]  [Naught Coin](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/naught-coin)
- [x]  [Preservation](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/preservation)
- [x]  [Recovery](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/recovery)
- [ ]  [MagicNumber](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/magic-number)
- [x]  [Alien Codex](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/alien-codex)
- [x]  [Denial](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/denial)
- [x]  [Shop](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/shop)
- [x]  [Dex](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/dex)
- [x]  [Dex Two](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/dex-two)
- [x]  [Puzzle Wallet](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/puzzle-wallet)
- [x]  [Motorbike](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/motorbike)
- [x]  [DoubleEntryPoint](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/double-entry-point)
- [x]  [Good Samaritan](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/good-samaritan)
- [x]  [Gatekeeper Three](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/gatekeeper-three)