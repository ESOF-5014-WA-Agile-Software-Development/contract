const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const MarketModule = buildModule("MarketModule", (m) => {
  const deployer = m.getAccount(0);
  const market = m.contract("Market");

  return { market };
});

module.exports = MarketModule;