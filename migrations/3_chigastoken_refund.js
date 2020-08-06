var GasTokenRefundModule = artifacts.require("./GasTokenRefundModuleV2.sol");

module.exports = function(deployer) {
    deployer.deploy(GasTokenRefundModule).then(function (gasTokenRefundModule) {
        gasTokenRefundModule.setup('0x0000000000000000000000000000000000000001')
        return gasTokenRefundModule
    });
};
