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
- [ ]  [Hello Ethernaut](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/hello-ethernaut)
- [ ]  [Fallback](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/fallback)
- [ ]  [Fallout](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/fallout)
- [ ]  [Coin Flip](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/coin-flip)
- [ ]  [Telephone](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/telephone)
- [ ]  [Token](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/token)
- [ ]  [Delegation](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/delegation)
- [ ]  [Force](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/force)
- [ ]  [Vault](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/vault)
- [ ]  [King](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/king)
- [ ]  [Re-entrancy](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/re-entrancy)
- [ ]  [Elevator](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/elevator)
- [ ]  [Privacy](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/privacy)
- [ ]  [Gatekeeper One](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/gatekeeper-one)
- [ ]  [Gatekepper Two](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/gatekeeper-two)
- [ ]  [Naught Coin](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/naught-coin)
- [ ]  [Preservation](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/preservation)
- [ ]  [Recovery](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/recovery)
- [ ]  [MagicNumber](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/magic-number)
- [ ]  [Alien Codex](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/alien-codex)
- [ ]  [Denial](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/denial)
- [ ]  [Shop](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/shop)
- [ ]  [Dex](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/dex)
- [ ]  [Dex Two](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/dex-two)
- [ ]  [Puzzle Wallet](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/puzzle-wallet)
- [ ]  [Motorbike](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/motorbike)
- [ ]  [DoubleEntryPoint](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/double-entry-point)
- [ ]  [Good Samaritan](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/good-samaritan)
- [ ]  [Gatekeeper Three](https://github.com/CokeFung/ethernaut-solver-foundry/tree/main/test/gatekeeper-three)