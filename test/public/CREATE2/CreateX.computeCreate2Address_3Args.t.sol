// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {BaseTest} from "../../utils/BaseTest.sol";
import {CreateX} from "../../../src/CreateX.sol";

contract CreateX_ComputeCreate2Address_3Args_Public_Test is BaseTest {
    function testFuzz_ReturnsThe20ByteAddressWhereAContractWillBeStoredAndShouldNeverRevert(
        bytes32 salt,
        address deployer
    ) external {
        vm.startPrank(deployer);
        address createAddressComputedOnChain = address(new CreateX{salt: salt}());
        vm.stopPrank();
        // It returns the 20-byte address where a contract will be stored.
        // It should never revert.
        assertEq(
            createX.computeCreate2Address(salt, keccak256(type(CreateX).creationCode), deployer),
            createAddressComputedOnChain
        );
    }
}
