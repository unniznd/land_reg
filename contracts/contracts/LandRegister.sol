// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract LandRegister is  Ownable{
    struct Land{
        uint256 id;
        string location;
        uint256 area;
        uint256 pricePerArea;
        address payable owner;
        bool isListed;
    }
    
    mapping(uint => Land) public lands;
    uint256 public landCount;

    event LandRegistered(uint256 id, string location, uint256 area, 
                        uint256 pricePerArea, address payable owner);

    event LandTransferred(uint256 id, address payable oldOwner, address payable newOwner);
    event LandBought(uint256 id, address payable oldOwner, address payable newOwner);
    
    constructor(){
        landCount = 0;
    }
    
    function registerLand(
        address payable owner, string memory _location, 
        uint256 _area, uint256 _pricePerArea
    ) public onlyOwner{
        landCount++;
        lands[landCount] = Land(landCount, _location, _area, _pricePerArea, owner, false);
        emit LandRegistered(landCount, _location, _area, _pricePerArea, owner);
    }

    function transferLand(uint _landId, address payable _newOwner) public{
        Land memory land = lands[_landId];

        require(msg.sender == land.owner, "Only owner can transfer the land");

        land.owner = _newOwner;
        land.isListed = false;
        lands[_landId] = land;

        emit LandTransferred(_landId, _newOwner, _newOwner);
    }
    
    function buyLand(uint _landId, address payable _newOwner) public {
        Land memory land = lands[_landId];

        require(land.isListed == true, "Land is not listed");
        // require(msg.value >= land.pricePerArea * land.area, "Insufficient balance");
        
        land.owner = _newOwner;
        land.isListed = false;
        lands[_landId] = land;

        // payable(land.owner).transfer(msg.value);

        emit LandBought(_landId, _newOwner, _newOwner);
    }

    function listLand(uint256 _landId, uint256 _pricePerArea) public{
        Land memory land = lands[_landId];
        require(msg.sender == land.owner, "Only owner can list the land");
        land.isListed = true;
        land.pricePerArea = _pricePerArea;
        lands[_landId] = land;
    }

    function unListLand(uint _landId) public{
        Land memory land = lands[_landId];
        require(msg.sender == land.owner, "Only owner can unlist the land");
        land.isListed = false;
        lands[_landId] = land;
    }
    
    function getLands(address payable _owner) public view returns(Land[] memory){
        uint256 count = 0;
        for(uint i = 1; i<=landCount; i++){
            if(lands[i].owner == _owner){
                count++;
            }
        }
        Land[] memory landsOfUser = new Land[](count);
        uint256 j = 0;
        for(uint i = 1; i<=landCount; i++){
            if(lands[i].owner == _owner){
                landsOfUser[j] = lands[i];
                j++;
            }
        }
        return landsOfUser;
    }

    function getListedLand() public view returns(Land[] memory){
        uint256 count = 0;
        for(uint i = 1; i<=landCount; i++){
            if(lands[i].isListed == true){
                count++;
            }
        }
        Land[] memory listedLands = new Land[](count);
        uint256 j = 0;
        for(uint i = 1; i<=landCount; i++){
            if(lands[i].isListed == true){
                listedLands[j] = lands[i];
                j++;
            }
        }
        return listedLands;
    }


}