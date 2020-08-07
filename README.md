<h1 align=center><code>Gas Saver Gnosis Safe Module</code></h1>

A collection of smart contracts to save gas on Ethereum in a [Gnosis Safe Wallet](https://gnosis-safe.io/)
leveraging [GST2](https://gastoken.io/) or [CHI](https://medium.com/@1inch.exchange/everything-you-wanted-to-know-about-chi-gastoken-a1ba0ea55bf3)
tokens

### Contract addresses

GasTokenRefundModuleV1 MasterCopy (GST2) [0x789659de58350311f50c4c9ceefcdf8cdf8941d7](https://etherscan.io/address/0x789659de58350311f50c4c9ceefcdf8cdf8941d7)
GasTokenRefundModuleV2 MasterCopy (CHI)  [0x8632963c81e5a4bb1f28ebeee6a70a1a92b0384b](https://etherscan.io/address/0x8632963c81e5a4bb1f28ebeee6a70a1a92b0384b)

### How To Setup

1. Deploy a Gnosis Proxy using the [factory](https://etherscan.io/address/0x76e2cfc1f5fa8f6a5b3fc4c8f4788f0116861f9b) to instantiate your custom module (CHI and/or GST2)
2. Setup your wallet on the proxy you've just deployed calling `setup(address walletAddress)`
3. Approve your proxy to spend on behalf of your Gnosis Safe your gas tokens 
[GST2](https://etherscan.io/token/0x0000000000b3f879cb30fe243b4dfee438691c04) or [CHI](https://etherscan.io/token/0x0000000000004946c0e9F43F4Dee607b0eF1fA1c)

TBC (still to technical)

### Next steps

- [x] Deliver PoC
- [ ] Realize a simple UI which create the (proxy) module for the user and allow to buy easily GST2/CHI (e.g. UniSwap, direct minting or via HAL)
- [ ] Complete the UI adding the possibility to execute any tx (e.g. like Send button on Gnosis Safe)
- [X] <s>Expose a function to mint tokens on behalf of the users when network gas price is below a threshold defined by the user and until a predefined cap (i.e. mint when below 5 Gwei at max 10 tokens)</s> DONE with [HAL](https://9000.hal.xyz/recipes/1inch-buy-chi-token)

