pragma solidity >=0.4.21 <0.6.0;

contract ArtPerpet {

  mapping(address => string) public artHash;
  address public devOwner;
  address public charity;
  mapping(address =>address) public bidder;
  mapping(address =>uint) public highestBid;
  mapping (address => uint) pendingWithdraws;
  mapping(address => uint) creationTime;
  uint public bidTime = 1 weeks;
  uint public devAmount = 1;
  uint public charityAmount = 90;
  uint public artistAmount = 9;

  constructor() public {
    devOwner = msg.sender;
  }

  function setArtHash(string artHashIn){
    artHash[msg.sender] = artHashIn;
    creationTime[msg.sender] = now;
  }

  function placeBid(address artist) public checkTimeGo(now) checkBid(msg.sender){
      // Return eth to the previous bidder    
      // set new highest bidder addr to msg.sender if checkBid is true
      bidder[artist] = msg.sender;
      // Set the bid
      highestBid[artist] = msg.value;
    }

  // Bidding is over
  function awardBid (string artHashToCheck) public payable checkArtist(artHashToCheck) checkTimeStop(now){ 
    pendingWithdraws[devOwner] = (devAmount * highestBid[msg.sender]);
    pendingWithdraws[msg.sender] = (artistAmount * highestBid[msg.sender]);
    pendingWithdraws[charity] = (charityAmount * highestBid[msg.sender]);
    withdraw();  
    // Send to NFT contract
    // send funds to charity address
    // reset timer
    creationTime[msg.sender] = now;
  }

  //Standard Withdraw function
  function withdraw() public {
    uint amount = pendingWithdraws[msg.sender];
    pendingWithdraws[msg.sender] = 0;
    msg.sender.transfer(amount);
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
  // Check to see if it's an artist
  modifier checkArtist(string artHashCheck) { 
        /*if((artHash[msg.sender] = artHashCheck)){
          _; 
        }*/
        _;
  }
  modifier onlyOwner{ 
    require (
      msg.sender == devOwner,
      "Only owner can call this function"
      ); 
    _;
  }
}
  