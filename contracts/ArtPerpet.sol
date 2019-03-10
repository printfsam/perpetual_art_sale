pragma solidity >=0.4.21 <0.6.0;

contract ArtPerpet {
  struct ArtPiece {
    address artist;
    string artHash;
    address highestBidder;
    uint highestBid;
    uint bidInterval;
    uint creationTime;
    uint startTime;
    uint endTime;
  }


  mapping (string => ArtPiece) gallary;
  address public owner;
  mapping (address => uint) public pendingWithdraws;

  uint public ownerAmount = 1;
  uint public artistAmount = 50;
  uint public purchaserAmount = 49;

  constructor() public {
    owner = msg.sender;
  }

  function newAuction (string artHash,uint bidInterval) public {
    uint auctionEndTime = now + bidInterval;
    address bidder;
    uint highestBid = 0;
    gallary[artHash] = ArtPiece(msg.sender,artHash,bidder,highestBid,bidInterval,now,now,auctionEndTime);
  }

  function placeBid(string artHash) public payable {
    require(now <= gallary[artHash].endTime,"Bidding Over");
    require(msg.value > gallary[artHash].highestBid, "Someone Bid Higher");
    //Return money to sender//////////////////////////////////////////////////////////////
    // else
    gallary[artHash].highestBidder = msg.sender;
    gallary[artHash].highestBid = msg.value;
  }

  // Bidding is over
  function awardBid (string artHash) public payable { 
    require(now >= gallary[artHash].endTime,"Bidding Over");

    owner.transfer(ownerAmount * gallary[artHash].highestBid);
    gallary[artHash].artist.transfer(artistAmount * gallary[artHash].highestBid);
    gallary[artHash].startTime = now;
    gallary[artHash].endTime = now + gallary[artHash].bidInterval;
  }

  //Standard Withdraw function
  function withdraw() public returns(bool){
    uint returnAmount = pendingWithdraws[msg.sender];
    // if they deserve nothing, give them nothing
    if(returnAmount == 0 ){
      pendingWithdraws[msg.sender] = 0;
      // Send the amount, if returns false then return false
      if(!msg.sender.send(returnAmount)){
        pendingWithdraws[msg.sender] = returnAmount;
        return false;
      }
      return true;
    }

  }

}
  