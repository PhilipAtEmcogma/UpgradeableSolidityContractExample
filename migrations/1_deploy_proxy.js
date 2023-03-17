//defining contracts to deploy
// remeber to require the actual contract name, not the file name that holds the contact
const Dogs = artifacts.require('Dogs');
const DogsUpdated = artifacts.require('Dogs');
const Proxy = artifacts.require('Proxy');

module.exports = async function(deployer, network, accounts){
    //use new() to deploy the Dogs contract and save it into a constances
    // use await because its an async function
    const dogs = await Dogs.new()
    const proxy = await Proxy.new(dogs.address);

    // letting solidity to think the proxy contract is indeed the actual dog contract
    //  below is let solidity to create an instance of the Dogs contract but at the addres of the proxy contract that is already deployed
    var proxyDog = await Dogs.at(proxy.address);

    //deploy new DogsUpdate instance to replace the old Dogs contract
    const dogsUpdated = await DogsUpdated.new();

    //calling the upgrade function from the proxy contract to change contract address from Dogs contract to DogsUpdated contract
    proxy.upgrade(dogsUpdated.address);

    // redirct the address such that truffle thinks DogsUpdate contract is indeed the proxy contract
    proxyDog = await DogsUpdated.at(proxy.address);
    //sent from current account address (accounts[0]). i.e. the developer's address
    // and initialise proxy state
    proxyDog.initialize(accounts[0])

}
