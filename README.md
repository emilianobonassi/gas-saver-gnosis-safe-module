## GasTokenRefund Gnosis Safe Module

A simple module to use [GST2](https://gastoken.io/) in a [Gnosis Safe Wallet](https://gnosis-safe.io/)

### Contract addresses

GasTokenRefundModuleV1 [0x789659de58350311f50c4c9ceefcdf8cdf8941d7](https://etherscan.io/address/0x789659de58350311f50c4c9ceefcdf8cdf8941d7)

### How To Setup

1. Deploy a Gnosis Proxy using the [factory](https://etherscan.io/address/0x76e2cfc1f5fa8f6a5b3fc4c8f4788f0116861f9b) to instantiate your custom module 
2. Setup your wallet on the proxy you've just deployed calling `setup(address walletAddress)`
3. Approve your proxy to spend on behalf of your Gnosis Safe [GST2](https://etherscan.io/token/0x0000000000b3f879cb30fe243b4dfee438691c04) tokens

TBC (still to technical)

### Next steps

- [x] Deliver PoC
- [ ] Realize a simple UI which create the (proxy) module for the user and allow to buy easily GST2 (e.g. UniSwap or direct minting)
- [ ] Complete the UI adding the possibility to execute any tx (e.g. like Send button on Gnosis Safe)
- [ ] Expose a function to mint tokens on behalf of the users when network gas price is below a threshold defined by the user and until a predefined cap (i.e. mint when below 5 Gwei at max 10 tokens)

