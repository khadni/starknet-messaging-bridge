// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./interfaces/IStarknetCore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// interface IStarknetCore {
//     /**
//       Sends a message to an L2 contract.
//     */
//     function sendMessageToL2(
//         uint256 to_address,
//         uint256 selector,
//         uint256[] calldata payload
//     ) external virtual;

//     /**
//       Consumes a message that was sent from an L2 contract.
//     */
//     function consumeMessageFromL2(uint256 fromAddress, uint256[] calldata payload) external virtual;
// }

/**
  Demo contract for L1 <-> L2 interaction between an L2 StarkNet contract and this L1 solidity
  contract.
*/
contract L1L2 {
    // The StarkNet core contract.
    IStarknetCore starknetCore;

    // The selector of the ex2 l1_handler.
    uint256 constant EX2_SELECTOR =
        897827374043036985111827446442422621836496526085876968148369565281492581228;

    // The evaluator address on L2
    uint256 constant EvaluatorContractAddress =
        0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99;
    /**
      Initializes the contract state.
    */

    constructor(
        address starknetCore_
    ) public {
        starknetCore = IStarknetCore(starknetCore_);
    }

    function sendMsgToL2Evaluator(uint256 l2_user) public {
        uint256[] memory payload = new uint256[](1);
        payload[0] = l2_user;

        starknetCore.sendMessageToL2(
            EvaluatorContractAddress,
            EX2_SELECTOR,
            payload
        );
    }
}
