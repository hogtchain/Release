// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/math/Math.sol";

contract Epoch {
    using SafeMath for uint256;

    uint256 private period;
    uint256 private startBlock;
    uint256 private lastExecutedAt;
    uint256 public epoch = 0;
    /* ========== CONSTRUCTOR ========== */

    constructor(
        uint256 _period,
        uint256 _startBlock,
        uint256 _startEpoch
    ) public {
        period = _period; 
        startBlock = _startBlock; 
        lastExecutedAt = startBlock.add(_startEpoch.mul(period)); 
    }

    /* ========== Modifier ========== */

    modifier checkEpoch {
        require(block.number > startBlock, 'Epoch: not started yet');
        require(getCurrentEpoch() >= getNextEpoch(), 'Epoch: not allowed');

        _;
        epoch = epoch.add(1);
        lastExecutedAt = block.number;
    }

    /* ========== VIEW FUNCTIONS ========== */

    function getLastEpoch() public view returns (uint256) {
        return lastExecutedAt.sub(startBlock).div(period);
    }

    function getCurrentEpoch() public view returns (uint256) {
        return Math.max(startBlock, block.number).sub(startBlock).div(period);
    }

    function getNextEpoch() public view returns (uint256) {
        if (startBlock == lastExecutedAt) { 
            return getLastEpoch(); 
        }
        return getLastEpoch().add(1); 
    }

    function nextEpochPoint() public view returns (uint256) {
        return startBlock.add(getNextEpoch().mul(period));
    }


    function getPeriod() public view returns (uint256) {
        return period;
    }

    function getstartBlock() public view returns (uint256) {
        return startBlock;
    }
}