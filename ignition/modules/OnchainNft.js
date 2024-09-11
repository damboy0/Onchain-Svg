const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const OnChainNFTModule = buildModule("OnChainNFTModule", (m) => {

  const onchainnft = m.contract("OnChainNFT");

  return { onchainnft };
});

module.exports = OnChainNFTModule;
