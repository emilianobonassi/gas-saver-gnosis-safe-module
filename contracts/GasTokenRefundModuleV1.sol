pragma solidity 0.5.16;

import "@openzeppelin/contracts/math/SafeMath.sol";

import "@gnosis.pm/safe-contracts/contracts/base/Module.sol";
import "@gnosis.pm/safe-contracts/contracts/base/ModuleManager.sol";
import "@gnosis.pm/safe-contracts/contracts/base/OwnerManager.sol";

import "./interfaces/IGST2.sol";


/// @title GasToken Refund Module - Allows to execute transactions using Gas Tokens.
/// @author Emiliano Bonassi - <bonassi.emiliano@gmail.com>
contract GasTokenRefundModuleV1 is Module {
    using SafeMath for uint256;

    string public constant NAME = "GasToken Refund Module";
    string public constant VERSION = "1.0.0";

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
    ) public returns (bool) {
        uint256 initialGas = gasleft();
        // Only Safe owners are allowed to execute transactions.
        require(OwnerManager(address(manager)).isOwner(msg.sender), "Method can only be called by an owner");
        require(manager.execTransactionFromModule(to, value, data, Enum.Operation.Call), "Could not execute transaction");

        // Refund

        uint256 MINT_BASE = 32254;
        uint256 MINT_TOKEN = 36543;
        uint256 FREE_BASE = 14154;
        uint256 FREE_TOKEN = 6870;
        uint256 REIMBURSE = 24000;

        uint256 mintPrice = 1000000000;

        uint256 tokens = initialGas.sub(gasleft()).add(FREE_BASE).div(REIMBURSE.mul(2).sub(FREE_TOKEN));

        uint256 mintCost = MINT_BASE.add(tokens.mul(MINT_TOKEN));
        uint256 freeCost = FREE_BASE.add(tokens.mul(FREE_TOKEN));
        uint256 maxreimburse = tokens.mul(REIMBURSE);

        uint256 efficiency = maxreimburse.mul(tx.gasprice).mul(100).div(
            mintCost.mul(mintPrice).add(freeCost.mul(tx.gasprice))
        );

        if (efficiency > 100) {
            uint256 tokensToFree = tokens;
            uint256 safeNumTokens = 0;
            uint256 gas = gasleft();

            if (gas >= 27710) {
                safeNumTokens = gas.sub(27710).div(1148 + 5722 + 150);
            }

            if (tokensToFree > safeNumTokens) {
                tokensToFree = safeNumTokens;
            }

            IGST2 gasToken = IGST2(0x0000000000b3F879cb30FE243b4Dfee438691c04);

            uint256 gasTokenBal = gasToken.balanceOf(address(manager));

            if (tokensToFree > 0 && gasTokenBal >= tokensToFree) {
                gasToken.freeFromUpTo(address(manager), tokensToFree);
            }
        }

        return true;
    }
}
