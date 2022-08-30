// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IStarknetCore.sol";


contract L1ReceiveMsgFromL2 {
    // The StarkNet core contract.
    IStarknetCore starknetCore;

    constructor(address starknetCore_) public 
    {
        starknetCore = IStarknetCore(starknetCore_);
    }

     /**
      Consumes a message that was sent from an L2 contract.
     */
    function consumeMessage(uint256 _l2Evaluator, uint256 _l2User) public {   
        // Construct the message payload.     
        uint256[] memory payload = new uint256[](1);
        payload[0] = _l2User;

        // Consume the message from the StarkNet core contract.
        // This will revert the (Ethereum) transaction if the message does not exist.
        starknetCore.consumeMessageFromL2(_l2Evaluator, payload);
    }
        
}
