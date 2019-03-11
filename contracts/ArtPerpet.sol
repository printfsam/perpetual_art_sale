pragma solidity >=0.4.21 <0.6.0;

contract ArtPerpet {
  struct ArtPiece {
    address artist;
    string artHash;
    address highestBidder;
    uint highestBid;
    uint ownershipPeriod;
    uint creationTime;
    uint startTime;
    uint endTime;
  }


  mapping (address => ArtPiece) public gallary;

  address public owner;
  mapping (address => uint) public pendingWithdraws;

  uint public ownerAmount = 1;
  uint public artistAmount = 50;
  uint public purchaserAmount = 49;

  constructor() public {
    owner = msg.sender;
  }

  function newAuction (string _artHash,uint _ownershipPeriod) public {
    uint auctionPeriod = _ownershipPeriod * 1 days;
    uint auctionEndTime = now + (_ownershipPeriod * 1 days);
    address bidder;
    uint highestBid = 0;
    gallary[msg.sender] = ArtPiece(msg.sender,_artHash,bidder,highestBid,auctionPeriod,now,now,auctionEndTime);
  }

  function placeBid(address _artist) public payable {
    require(now <= gallary[_artist].endTime,"Bidding Over");
    require(msg.value > gallary[_artist].highestBid, "Someone Bid Higher");
    //Return money to sender//////////////////////////////////////////////////////////////
    // else
    gallary[_artist].highestBidder = msg.sender;
    gallary[_artist].highestBid = msg.value;
  }

  // Bidding is over
  function awardBid (address _artist) public payable { 
    require(now >= gallary[_artist].endTime,"Bidding Over");
    // Check if is artist
    require(msg.sender == gallary[_artist].artist, "Can only be collected by the Artist");
    owner.transfer(ownerAmount * gallary[_artist].highestBid);
    msg.sender.transfer(artistAmount * gallary[_artist].highestBid);
    gallary[_artist].startTime = now;
    gallary[_artist].endTime = now + gallary[_artist].ownershipPeriod;
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
  function getArtist(address _artist) view public returns(address){
    return gallary[_artist].artist; 
  }
  function getArtHash(address _artist) view public returns(string){
    return gallary[_artist].artHash;
  }
  function getHighestBidder(address _artist) view public returns(address){
    return gallary[_artist].highestBidder;
  }
  function getHighestBid(address _artist) view public returns(uint){
    return gallary[_artist].highestBid;
  }
  function getOwnershipPeriod(address _artist) view public returns(uint){
    return gallary[_artist].ownershipPeriod;
  }
  function getCreationTime(address _artist) view public returns(uint){
    return gallary[_artist].creationTime;
  }
  function getStartTime(address _artist) view public returns(uint){
    return gallary[_artist].startTime;
  }
  function getEndTime(address _artist) view public returns(uint){
    return gallary[_artist].endTime; 
  }

  

}
  