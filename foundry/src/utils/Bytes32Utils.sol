// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

library Bytes32Utils {
    function bytes32ToString(
        bytes32 _bytes32
    ) internal pure returns (string memory) {
        uint8 i = 0;
        while (i < 32 && _bytes32[i] != 0) {
            i++;
        }

        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }

        return string(bytesArray);
    }

    function stringToBytes32(
        string memory _string
    ) internal pure returns (bytes32) {
        return bytes32(bytes(_string));
    }
}
