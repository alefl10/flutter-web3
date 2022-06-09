const HelloWeb3 = artifacts.require("HelloWeb3");

module.exports = function (deployer) {
    deployer.deploy(HelloWeb3);
};
