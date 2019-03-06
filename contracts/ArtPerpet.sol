pragma solidity >=0.4.21 <0.6.0;

contract ArtPerpet {

  mapping(address => string) public artHash;
  address public devOwner;
  address public charity;
  mapping(address =>address) public bidder;
  mapping(address =>uint) public highestBid;
  mapping (address => uint) public pendingWithdraws;
  mapping(address => uint) public creationTime;
  uint public bidTime = 1 weeks;
  uint public devAmount = 1;
  uint public charityAmount = 90;
  uint public artistAmount = 9;

  constructor() public {
    devOwner = msg.sender;
    //charity = 0x627306090abab3a6e1400e9345bc60c78a8bef57;
  }

  function setArtHash(string artHashIn) public {//checkHash(artHashIn){
    artHash[msg.sender] = artHashIn;
    creationTime[msg.sender] = now;
  }

  function placeBid(address artist, uint amt) public {//checkTimeGo(now) checkBid(msg.sender){
      bidder[artist] = msg.sender;
      // Set the bid
      highestBid[artist] = amt;
    }

  // Bidding is over
  function awardBid (string artHashToCheck) public payable {//checkArtOwner(now) {//checkTimeStop(now){ 
    pendingWithdraws[devOwner] = /*(devAmount **/ highestBid[msg.sender];//);
    pendingWithdraws[msg.sender] = /*(artistAmount **/ highestBid[msg.sender];//);
    //pendingWithdraws[charity] = (charityAmount * highestBid[msg.sender]);
    // Send to NFT contract
    // reset timer
    creationTime[msg.sender] = now;
    withdraw();  
  }

  //Standard Withdraw function
  function withdraw() public {
    uint amountArtist = pendingWithdraws[msg.sender];
    uint amountDev = pendingWithdraws[devOwner];
    //uint amountCharity = pendingWithdraws[charity];
    //pendingWithdraws[charity] = 0;
    pendingWithdraws[msg.sender] = 0;
    pendingWithdraws[devOwner] = 0;
    msg.sender.transfer(amountArtist);
    devOwner.transfer(amountDev);
    //charity.transfer(amountCharity);
  }
  function getHighestBidder(address addr) public view returns(address){
    return bidder[addr];
  }
  // check the time to see if it's over the limit
  modifier checkTimeStop(uint _time) { 
    if(now >= (creationTime[msg.sender] + bidTime)){
      //stop bidding
      _; 
    }
  }

  modifier checkTimeGo(uint _time) { 
    if(now < (creationTime[msg.sender] + bidTime)){
      //stop bidding
      _; 
    }
  }
  // Check to see if the bid is higher than the current one on file
  modifier checkBid(address artist) { 
        if(msg.value > highestBid[artist]){
          _; 
        }
  }
  // Check to see if hash is already in there
  /*modifier checkHash(string artHashToCheck) { 
        if(artHash[msg.sender] = string(artHashToCheck)){
          _; 
        }
  }*/
/*  modifier checkArtOwner(uint _time) { 
    if(artHash[msg.sender])
    _; 
  }*/
  
  modifier onlyOwner{ 
    require (
      msg.sender == devOwner,
      "Only owner can call this function"
      ); 
    _;
  }
}
  