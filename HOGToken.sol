// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "@openzeppelin/contracts/utils/EnumerableSet.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "./utils/ERC20.sol";
import "./utils/ERC20Detailed.sol";
import "./utils/Ownable.sol";

contract HOGToken is Ownable, ERC20, ERC20Detailed("Heco Origin Token", "HOGT", 18) {
    using SafeMath for uint;
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet miners;
    uint totalMaxSupply = 500000000e18;

    function mint(address _to, uint256 _amount) public returns (bool) {
        require(miners.contains(msg.sender), "permission denied");

        if (totalSupply().add(_amount) > totalMaxSupply) {
            return false;
        }

        _mint(_to, _amount);
        return true;
    }

    function addMiner(address miner_) public onlyOwner {
        miners.add(miner_);
    }

    function removeMiner(address miner_) public onlyOwner {
        miners.remove(miner_);
    }
}
