pragma solidity >=0.4.21 <0.6.0;

contract ArtPerpet {

  mapping(address => string) public artHash;
  address public devOwner;
  address public charity;
  mapping(address =>address) public bidder;
  mapping(address =>uint) public highestBid;
  mapping (address => uint) pendingWithdraws;
  mapping(address => uint) creationTime;
  uint bidTime = 1 weeks;


  constructor() public {
    devOwner = msg.sender;
  }

  function setArtHash(string artHashIn){
    artHash[msg.sender] = artHashIn;
    creationTime[msg.sender] = now;
  }

  function placeBid(address artist) public checkBid{
      // Return eth to the previous bidder    
      // set new highest bidder addr to msg.sender if checkBid is true
      bidder[artist] = msg.sender;
      // Set the bid
      highestBid[artist] = msg.value;
    }

  // Bidding is over
  function awardBid () public payable { 
    // send to dev fund
    uint devAmount = (0.01 * highestBid[artist]);
    uint charityAmount = (0.90 * highestBid[artist]);
    uint artistAmount = (0.09 * highestBid[artist])
    pendingWithdraws[devOwner] = devAmount;
    pendingWithdraws[artist] = artistAmount;
    pendingWithdraws[charity] = charityAmount;
    withdraw();  
    // Send to NFT contract
    // send funds to charity address
    // reset timer 
  }

  //Standard Withdraw function
  function withdraw() public {
    uint amount = pendingWithdraws[msg.sender];
    pendingWithdraws[msg.sender] = 0;
    msg.sender.transfer(amount);
  }
  
  // check the time to see if it's over the limit
  modifier checkTime(uint _time) { 
    if(now >= (creationTime + bidTime){
      //stop bidding
      return false;
      _; 
    }
  }
  
  // Check to see if the bid is higher than the current one on file
  modifier checkBid(address artist) { 
        if(msg.value > highestBid[artist]){
          _; 
        }
  }

  modifier onlyOwner{ 
    require (
      msg.sender == devOwner,
      "Only owner can call this function"
      ); 
    _; 
  }
  