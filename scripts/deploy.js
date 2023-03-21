// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {

  const nftContract = await ethers.getContractFactory("MetaPass");

  // here we deploy the contract
  const deployedNFTContract = await nftContract.deploy();

  // wait for the contract to deploy
  await deployedNFTContract.deployed();

  // print the address of the deployed contract
  console.log("NFT Contract Address:", deployedNFTContract.address);

  const soulBoundNftContract = await ethers.getContractFactory("SoulBoundBadge");

  // here we deploy the contract
  const deployedsoulBoundNftContract = await soulBoundNftContract.deploy();

  // wait for the contract to deploy
  await deployedsoulBoundNftContract.deployed();
  console.log("Soul Bound NFT Contract Address:", deployedsoulBoundNftContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });