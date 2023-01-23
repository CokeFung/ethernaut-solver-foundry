# CoinFlip
### command
- executing on local network
    ```
    forge script script/CoinFlip/CoinFlip.s.sol
    ```
    or (cleaner output)
    ```
    forge script script/CoinFlip/CoinFlip.s.sol --silent
    ```
- executing on specified network (If it fails, try `source .env` first)
    ```
    forge script script/CoinFlip/CoinFlip.s.sol \
    --rpc-url $FOUNDRY_GOERLI_RPC_URL \
    --private-key $FOUNDRY_PRIVATE_KEY \
    --broadcast
    ```