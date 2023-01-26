# GatekeeperThree
### command
- executing on local network
    ```
    forge script script/GatekeeperThree/GatekeeperThree.s.sol --sender `your attacker address`
    ```
    or (cleaner output)
    ```
    forge script script/GatekeeperThree/GatekeeperThree.s.sol --silent --sender `your attacker address`
    ```
- executing on specified network (If it fails, try `source .env` first)
    ```
    orge script script/GatekeeperThree/GatekeeperThree.s.sol \
    --rpc-url $FOUNDRY_GOERLI_RPC_URL \
    --private-key $FOUNDRY_PRIVATE_KEY \
    --slow \
    --sender `your attacker address` \
    --broadcast
    ```