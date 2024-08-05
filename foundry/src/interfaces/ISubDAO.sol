// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Bytes32Utils} from "../utils/Bytes32Utils.sol";

abstract contract SubDAO is Ownable {
    using Bytes32Utils for bytes32;
    using Bytes32Utils for string;

    bytes32 private immutable i_name;
    bytes32 private immutable i_description;
    address private immutable i_ownerAddress;
    address private s_admin;

    constructor(
        string memory _name,
        string memory _description,
        address _admin,
        address _ownerAddress
    ) Ownable(msg.sender) {
        i_name = _name.stringToBytes32();
        i_description = _description.stringToBytes32();
        s_admin = _admin;
        i_ownerAddress = _ownerAddress;
    }

    function setNewAdmin(address _adminAddress) public onlyOwner {
        s_admin = _adminAddress;
    }

    function removeAdmin() public onlyOwner {
        s_admin = address(0);
    }

    function getName() public view returns (string memory) {
        return i_name.bytes32ToString();
    }

    function getDescription() public view returns (string memory) {
        return i_description.bytes32ToString();
    }

    function getProjectAdmin() public view returns (address) {
        return s_admin;
    }

    modifier onlyAuthorized() {
        require(
            msg.sender == s_admin || msg.sender == i_ownerAddress,
            "Caller is not Authorized"
        );
        _;
    }
}
