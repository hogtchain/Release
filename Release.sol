// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./Epoch.sol";


contract Release is Epoch {

  using SafeMath for uint256;

  uint public totalInitial;

  uint public amount;

  /// @notice Reference to token to drip (immutable)
  IERC20 public token;

  /// @notice Target to receive dripped tokens (immutable)
  address public target;

  /// @notice Amount that has already been dripped
  uint public dripped;
    // 1 day 28800
    // 1 quarterly 2592000
  constructor(uint period_, uint startBlock_, uint totalInitial_, uint amount_, IERC20 token_, address target_) public Epoch(period_, startBlock_, 0) {
    totalInitial = totalInitial_;
    amount = amount_;
    token = token_;
    target = target_;
  }

  function drip() public checkEpoch {
    require(dripped < totalInitial, "!drip");
    dripped = dripped.add(amount);
    token.transfer(target, amount);
  }
}
