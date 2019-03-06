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
	it('should passout award', async () => {
		let instance = await ArtPerpet.deployed();
		await instance.setArtHash("test Award");
		await instance.awardBid("test Award");
		let devOwner = await instance.devOwner.call();		
		let pendingDevReward = await instance.pendingWithdraws.call(devOwner);
		let pendingArtistReward = await instance.pendingWithdraws.call(web3.eth.accounts[0]);
		//assert.equal(creationTime.c[0],Date.now());
		//console.log(pendingDevReward, pendingArtistReward);
		let withdrawPeople = await instance.withdraw.call();
		console.log(pendingArtistReward);
		let artistRewardAfter = await instance.pendingWithdraws.call(web3.eth.accounts[0]);
		console.log(artistRewardAfter);
	});
});