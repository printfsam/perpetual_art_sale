const Migrations = artifacts.require("Migrations");
const Art = artifacts.require("ArtPerpet");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Art); 
};
