# Token
### command
- executing on local network
    ```
    forge script script/Token/Token.s.sol
    ```
    or (to avoid "Warning: Function state mutability can be restricted to view")
    ```
    forge script script/Token/Token.s.sol --ignored-error-codes 2018
    ```
- executing on specified network (If it fails, try `source .env` first)
    ```
    forge script script/Token/Token.s.sol \
    --rpc-url $FOUNDRY_GOERLI_RPC_URL \
    --private-key $FOUNDRY_PRIVATE_KEY \
    --broadcast
    ```