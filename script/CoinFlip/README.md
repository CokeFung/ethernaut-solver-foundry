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
    `--fork-block-number` should be more than `currentblock - 256`
    ```
    forge script script/CoinFlip/CoinFlip.s.sol \
    --private-key $FOUNDRY_PRIVATE_KEY \
    --fork-url $FOUNDRY_GOERLI_RPC_URL \
    --fork-block-number 8365750 \
    --slow \
    --broadcast \
    --skip-simulation
    ```