# PuzzleProxy
### command
- executing on local network
    ```
    forge script script/PuzzleProxy/PuzzleProxy.s.sol
    ```
- executing on specified network (If it fails, try `source .env` first)
    ```
    forge script script/PuzzleProxy/PuzzleProxy.s.sol \
    --rpc-url $FOUNDRY_GOERLI_RPC_URL \
    --private-key $FOUNDRY_PRIVATE_KEY \
    --broadcast
    ```