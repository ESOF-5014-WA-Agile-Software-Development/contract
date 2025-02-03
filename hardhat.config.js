/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-ignition");
require("dotenv").config();

module.exports = {
  solidity: "0.8.28",
  networks: {
    holesky: {
      url: `https://holesky.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      chainId: 17000
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      chainId: 11155111
    }
  }
};

/*
reserve list
    "@nomicfoundation/hardhat-chai-matchers": "^2.0.2",
    "@nomicfoundation/hardhat-ethers": "^3.0.5",
    "@nomicfoundation/hardhat-network-helpers": "^1.0.10",
    "@nomicfoundation/hardhat-toolbox": "^4.0.0",
    "@trivago/prettier-plugin-sort-imports": "^4.3.0",
    "@typechain/ethers-v6": "^0.5.1",
    "@typechain/hardhat": "^9.1.0",
    "@types/chai": "^4.3.11",
    "@types/fs-extra": "^11.0.4",
    "@types/mocha": "^10.0.6",
    "@types/node": "^20.10.4",
    "@typescript-eslint/eslint-plugin": "^6.14.0",
    "@typescript-eslint/parser": "^6.14.0",
    "chai": "^4.3.10",
    "cross-env": "^7.0.3",
    "eslint": "^8.56.0",
    "eslint-config-prettier": "^9.1.0",
    "ethers": "^6.9.0",
    "fs-extra": "^11.2.0",
    "hardhat-deploy": "^0.12.1",
    "hardhat-gas-reporter": "^1.0.9",
    "lodash": "^4.17.21",
    "mocha": "^10.2.0",
    "prettier": "^3.1.1",
    "prettier-plugin-solidity": "^1.2.0",
    "rimraf": "^5.0.5",
    "solhint": "^4.0.0",
    "solhint-plugin-prettier": "^0.1.0",
    "solidity-coverage": "^0.8.5",
    "ts-generator": "^0.1.1",
    "ts-node": "^10.9.2",
    "typechain": "^8.3.2",
    "typescript": "^5.3.3",
    "solc": "^0.8.28",
    "@nomicfoundation/hardhat-ignition-ethers": "^0.15.9",
    "@nomicfoundation/ignition-core": "^0.15.9"
 */