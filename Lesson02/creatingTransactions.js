const ethers = require('ethers');

const privateKey = '0x4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d';
const targetAddress = '0x429184b2450d69bfA86f9E6852cf509e02FD56cE';
const amount = '0.0001';

const provider = new ethers.providers.JsonRpcProvider();
const wallet = new ethers.Wallet(privateKey, provider);

const transaction = {
    to: targetAddress,
    value: ethers.utils.parseEther(amount)
};

const sendTransactionPromise = wallet.sendTransaction(transaction);

sendTransactionPromise.then((tx) => {

    const from = tx.from;
    const to = tx.to;
    const fromBalance = provider.getBalance(from);
    const targetBalance = provider.getBalance(to);

    console.log('\nTransaction successfully completed!');
    console.log(`Amount sent: ${amount} ETH`)

    fromBalance.then(x => {
        console.log(`Remaining balance: ${parseFloat(x / 1e18)} ETH`);
    });
    targetBalance.then(x => {
        console.log(`Target balance: ${parseFloat(x / 1e18)} ETH\n`);
    });
});