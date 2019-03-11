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

	it('should return time', async () => {
		//let instance = await ArtPerpet.deployed();
		//await instance.setArtHash("timeTest");
		//let creationTime = await instance.creationTime.call(web3.eth.accounts[0]);
		//assert.equal(creationTime.c[0],Date.now());
	});
	it('should set Higest Bid', async () => {
/*		let instance = await ArtPerpet.deployed();
		// Set Hash
		await instance.setArtHash("test Award");
		// Bid 
		await instance.placeBid(web3.eth.accounts[0],1000000000000000000, {from: web3.eth.accounts[1]});
		console.log("Owner:",web3.eth.accounts[0], " Highest Bidder", web3.eth.accounts[1]);
		let hbidder = await instance.getHighestBidder.call(web3.eth.accounts[0]);
		console.log(hbidder);
		let hbidderAmt = await instance.getHighestBidAmt.call(web3.eth.accounts[0]);
		console.log(web3.fromWei(hbidderAmt,'ether').toString());*/
	});
	it('should set award', async () => {
		/*let instance = await ArtPerpet.deployed();
		// Set Artist to Account 1
		await instance.setArtHash("test Award", {from: web3.eth.accounts[1]});
		/////////////////////////////////////////////////////////////////////////////////
		let artist = await instance.artHash.call(web3.eth.accounts[1]);
		let creationTimeStart = await instance.creationTime.call(web3.eth.accounts[1]);
		/////////////////////////////////////////////////////////////////////////////////
		console.log("Artist:", web3.fromWei(artist,'Gwei').toString());
		console.log("Creation Time:", web3.fromWei(creationTimeStart,'Gwei').toString());*/
		//await instance.placeBid(web3.eth.accounts[0],1000000000000000000, {from: web3.eth.accounts[1]}); 
		//let devOwner = await instance.devOwner.call();
		//let devAmt = await instance.pendingWithdraws.call(web3.eth.accounts[0]);
		//let artistAmt = await instance.highestBid.call(web3.eth.accounts[0]);
		//console.log("Dev Amount before:", web3.fromWei(devAmt,'Gwei').toString(),"Bidder Amt:",web3.fromWei(artistAmt,'Gwei').toString());
		//await instance.awardBid("test Award");
		//let devAmtAfter = await instance.pendingWithdraws.call(web3.eth.accounts[0]);
		//let artistAmtAfter = await instance.highestBid.call(web3.eth.accounts[0]);
		//console.log("Dev Amt After:",web3.fromWei(devAmtAfter,'Gwei').toString(),"Bidder Withdraw:",web3.fromWei(artistAmtAfter,'Gwei').toString());
		//await instance.withdraw();
	});
});