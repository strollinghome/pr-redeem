// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";

interface ICrowdfund {
    function redeem(uint256 amount) external;

    function balanceOf(address account) external returns (uint256);
}

contract Deploy is Script {
    ICrowdfund public crowdfund =
        ICrowdfund(address(0x1B7D237406f51978d48BFCEc2211c5EB97a344AA));

    function run() public {
        address[] memory holder = vm.envAddress("HOLDERS", ",");

        for (uint256 i = 0; i < holder.length; i++) {
            vm.startPrank(holder[i]);
            crowdfund.redeem(crowdfund.balanceOf(holder[i]));
            vm.stopPrank();
        }
    }
}
