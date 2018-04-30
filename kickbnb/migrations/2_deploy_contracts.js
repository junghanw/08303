
const Victim = artifacts.require('./KickBNB.sol')
const Attacker = artifacts.require('./Attacker.sol')

module.exports = function(deployer) {
  deployer
    .deploy(Victim, web3.toWei(10,"ether"), 10,
            {from: "0x5aeda56215b167893e80b4fe645ba6d5bab767de"})
    .then(() =>
      deployer.deploy(Attacker, Victim.address)
    )
}