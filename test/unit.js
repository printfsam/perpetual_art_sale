const ArtPerpet = artifacts.require("ArtPerpet");


contract("ArtPerpet", accounts => {
	it('should give back the hash', async () => {
		let instance = await ArtPerpet.deployed();
		await instance.setArtHash("samtest");
		let hashOut = await instance.artHash.call(web3.eth.accounts[0]);
		assert.equal(hashOut,"samtest");
	});

	it('should return time', async () => {
		let instance = await ArtPerpet.deployed();
		await instance.setArtHash("timeTest");
		//let creationTime = await instance.creationTime.call(web3.eth.accounts[0]);
		//assert.equal(creationTime.c[0],Date.now());
	});
	it('should set Higest Bid', async () => {
		let instance = await ArtPerpet.deployed();
		// Set Hash
		await instance.setArtHash("test Award");
		// Bid 
		await instance.placeBid(web3.eth.accounts[0],1, {from: web3.eth.accounts[1]});
		console.log("Owner:",web3.eth.accounts[0], " Highest Bidder", web3.eth.accounts[1]);
		let hbidder = await instance.getHighestBidder.call(web3.eth.accounts[0]);
		console.log(hbidder);
	});
	it('should set award', async () => {
		let instance = await ArtPerpet.deployed();
		// Set Hash
		await instance.setArtHash("test Award");
		// Bid 
		await instance.placeBid(web3.eth.accounts[0],1, {from: web3.eth.accounts[1]});
		let devOwner = await instance.devOwner.call();		
		let devAmt = await instance.pendingWithdraws.call(devOwner);
		let artistAmt = await instance.pendingWithdraws.call(web3.eth.accounts[0]);
		//console.log(web3.fromWei(devAmt,'Gwei').toString(),web3.fromWei(artistAmt,'Gwei').toString());
		await instance.awardBid("test Award");
		let devAmtAfter = await instance.pendingWithdraws.call(devOwner);
		let artistAmtAfter = await instance.pendingWithdraws.call(web3.eth.accounts[0]);
		//console.log(web3.fromWei(devAmtAfter,'Gwei').toString(),web3.fromWei(artistAmtAfter,'Gwei').toString());
	});
});