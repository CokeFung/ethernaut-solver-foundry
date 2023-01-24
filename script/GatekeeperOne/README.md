# GatekeeperOne
### command
- executing on local network
    ```
    forge script script/GatekeeperOne/GatekeeperOne.s.sol --sender `your attacker address`
    ```
    or (cleaner output)
    ```
    forge script script/GatekeeperOne/GatekeeperOne.s.sol --silent --sender `your attacker address`
    ```
- executing on specified network (If it fails, try `source .env` first)
    ```
    forge script script/GatekeeperOne/GatekeeperOne.s.sol \
    --rpc-url $FOUNDRY_GOERLI_RPC_URL \
    --private-key $FOUNDRY_PRIVATE_KEY \
    --broadcast \
    --sender `your attacker address`
    ```