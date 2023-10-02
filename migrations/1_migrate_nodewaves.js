const Nodewaves = artifacts.require("Nodewaves");
const Usdt = artifacts.require("USDT");
module.exports = async function (deployer) {
  await deployer.deploy(Usdt);
  const usdt = await Usdt.deployed();
  // console.log("USDT address: ", usdt.address);
  await deployer.deploy(Nodewaves, usdt.address, usdt.address);
  const nodewaves = await Nodewaves.deployed();

  // console.log("Nodewaves address: ", nodewaves.address);
};
