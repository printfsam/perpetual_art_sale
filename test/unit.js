const ArtPerpet = artifacts.require("ArtPerpet");


contract("ArtPerpet", accounts => {
	it('should create a new Art Piece', async () => {
		let instance = await ArtPerpet.deployed();
		let ownershipPeriod = 7; // days
		await instance.newAuction("samteststring",ownershipPeriod,{from: web3.eth.accounts[1]});
		let account1 = web3.eth.accounts[1];
		//console.log(artist,web3.eth.accounts[1]);
		let artist = await instance.getArtist(account1);
		assert.equal(artist,account1);
  		let artHash = await instance.getArtHash(account1);
  		assert.equal(artHash,"samteststring");
  		//await instance.getHighestBid(account1);
  		//await instance.getHighestBidder(account1);
  		//await instance.getCreationTime(account1);
  		//await instance.getStartTime(acount1);
  		//await instance.getEndTime(account1);
	});
});