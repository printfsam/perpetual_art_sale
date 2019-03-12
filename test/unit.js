const ArtPerpet = artifacts.require("ArtPerpet");


contract("ArtPerpet", accounts => {
	//let accounts = await web3.eth.getAccounts();
	let ownershipPeriod = 7; // days
	let account1 = accounts[1];
	let bidderAddr = accounts[2];
	let instance;
	before(async function(){
		ArtPerpet.autogas = true;
		instance = await ArtPerpet.deployed();

		let ownershipPeriod = 7; // days
		await instance.newAuction("samteststring",ownershipPeriod,{from: account1});
	});
  		
	it('should return the artist addr', async () => {
		let artist = await instance.getArtist(account1);			
		assert.equal(artist,account1);
  		let artHash = await instance.getArtHash(account1);
  		//console.log(artHash);
  		assert.equal(artHash,"samteststring");
	});
	it('Bid should be set and returned', async () => {
		let artist = await instance.getArtist(account1);
		await instance.placeBid(artist,{from:bidderAddr,value:1000000000000000000});
		let bidder = await instance.getHighestBidder(account1);
		let bid = await instance.getHighestBid(account1);
		//console.log("Bid in Ether: 1 ",web3.utils.fromWei(bid,'ether').toString());
		//console.log("Placed a Bid: ",bidder," ",bidderAddr);
		assert.equal(bidder,bidderAddr);
		assert.equal(1,web3.utils.fromWei(bid,'ether').toString());

	});
	it('Award should not be returned, bidding not over', async () => {
		ArtPerpet.autogas = true;
		let artist = await instance.getArtist(account1);
		await instance.placeBid(artist,{from:bidderAddr,value:2000000000000000000});
		try{
			await instance.awardBid(artist,{from:artist});			
		}
		catch(error){
		}

	});
	it('Award should be sent out, bidding over', async () => {
		let artist = await instance.getArtist(account1);
		await instance.placeBid(artist,{from:bidderAddr,value:3000000000000000000});
		// set end time to after start time 
		await instance.setEndTime(artist,7);
		await instance.awardBid(artist,{from:artist});
		
		let ownerAmt = await web3.eth.getBalance(accounts[0]);
		let artistAmt = await web3.eth.getBalance(artist);
		
		//console.log("Owner Receives: 100.25819532 ",web3.utils.fromWei(ownerAmt,'ether').toString());
		//console.log("Artist Receives:102.69543152 ",web3.utils.fromWei(artistAmt,'ether').toString());
		assert.equal('100.25826642',web3.utils.fromWei(ownerAmt,'ether').toString());
		assert.equal('102.69543152',web3.utils.fromWei(artistAmt,'ether').toString());

	});
	// TODO: test times in awardbid method
});