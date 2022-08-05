const { network } = require("hardhat")

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const args = [120, "0x70997970C51812dc3A010C7d01b50e0d17dc79C8"]
    
    const simpleAuction = await deploy("SimpleAuction", {
        from: deployer,
        args: args,
        log: true,
        waitConfirmation: network.config.blockConfirmations || 1,
    })

    console.log(`contract deployed at ${simpleAuction.address}`)
}