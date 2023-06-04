require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
const dotenv = require("dotenv");

dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks:{
	sepolia_ :{
		url: process.env.SEPOLIA_PK,
		accounts:[process.env.PRIVATE_KEY],
	}
  },
  etherscan:{
	apiKey: process.env.API_KEY,
  }
};
