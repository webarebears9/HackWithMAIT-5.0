// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DrugInventory {
    struct Drug {
        string name;
        uint256 quantity;
        uint256 price;
    }

    mapping(uint256 => Drug) public inventory;
    uint256 public drugCount;
    address public admin;

    event DrugAdded(uint256 drugId, string name, uint256 quantity, uint256 price);
    event DrugUpdated(uint256 drugId, uint256 quantity);

    constructor() {
        admin = msg.sender; // Set the contract creator as the admin
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    function addDrug(string memory name, uint256 quantity, uint256 price) public onlyAdmin {
        drugCount++;
        inventory[drugCount] = Drug(name, quantity, price);
        emit DrugAdded(drugCount, name, quantity, price);
    }

    function updateDrug(uint256 drugId, uint256 quantity) public onlyAdmin {
        require(drugId > 0 && drugId <= drugCount, "Invalid drug ID");
        inventory[drugId].quantity = quantity;
        emit DrugUpdated(drugId, quantity);
    }

    function getDrugDetails(uint256 drugId) public view returns (string memory, uint256, uint256) {
        require(drugId > 0 && drugId <= drugCount, "Invalid drug ID");
        Drug memory drug = inventory[drugId];
        return (drug.name, drug.quantity, drug.price);
    }
}
