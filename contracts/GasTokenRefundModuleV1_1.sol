pragma solidity 0.5.16;

import "@gnosis.pm/safe-contracts/contracts/base/Module.sol";
import "@gnosis.pm/safe-contracts/contracts/base/ModuleManager.sol";
import "@gnosis.pm/safe-contracts/contracts/base/OwnerManager.sol";

import "@emilianobonassi/gas-saver/GST2GasSaver.sol";


/// @title GasToken Refund Module - Allows to execute transactions using Gas Tokens.
/// @author Emiliano Bonassi - <bonassi.emiliano@gmail.com>
contract GasTokenRefundModuleV1_1 is Module, GST2GasSaver {
    using SafeMath for uint256;

    string public constant NAME = "GasToken Refund Module";
    string public constant VERSION = "1.1.0";

    /// @dev Setup function sets initial storage of contract.
    /// @param _manager Address of the manager, the safe contract.
    function setup(address payable _manager) public {
        require(address(manager) == address(0), "Manager has already been set");
        if (_manager == address(0)) {
            manager = ModuleManager(msg.sender);
        } else {
            manager = ModuleManager(_manager);
        }
    }

    /// @dev Returns if executed correctly.
    /// @param to Recipient.
    /// @param value Value.
    /// @param data Data.
    /// @return Returns if transaction can be executed.
    function executeWithGasTokenRefund(
        address to,
        uint256 value,
        bytes memory data
    )
    public
    saveGas(address(uint160(address(manager))))
    returns (bool) {
        // Only Safe owners are allowed to execute transactions.
        require(OwnerManager(address(manager)).isOwner(msg.sender), "Method can only be called by an owner");
        require(manager.execTransactionFromModule(to, value, data, Enum.Operation.Call), "Could not execute transaction");

        return true;
    }
}
