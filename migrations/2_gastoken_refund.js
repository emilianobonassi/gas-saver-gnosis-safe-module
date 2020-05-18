var GasTokenRefundModule = artifacts.require("./GasTokenRefundModule.sol");

module.exports = function(deployer) {
    deployer.deploy(GasTokenRefundModule).then(function (gasTokenRefundModule) {
        gasTokenRefundModule.setup('0x0000000000000000000000000000000000000001')
        return gasTokenRefundModule
    });
};
