const ethers = require('ethers');
const crypto = require('crypto');
const ethUtil = require('ethereumjs-util');

let privateKey = '0x4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d';

// Cheque parameters

let contractAddr = '0xe982E462b094850F12AF94d21D470e21bE9D0E9C';
let to = '0xffcf8fdee72ac11b5c542428b35eef5769c409f0';
let amount = '1.0';


async function signPayment() {
    let wallet = new ethers.Wallet(privateKey);
    let amountWei = ethers.utils.parseEther(amount);
    const nonce = ethUtil.bufferToHex(crypto.randomBytes(32));

    let message = ethers.utils.concat([
        ethers.utils.hexZeroPad(contractAddr, 20),
        ethers.utils.hexZeroPad(to, 20),
        ethers.utils.hexZeroPad(ethers.utils.hexlify(amountWei), 32),
        nonce
    ]);

    let messageHash = ethers.utils.keccak256(message);

    let sig = await wallet.signMessage(ethers.utils.arrayify(messageHash));
    let splitSig = ethers.utils.splitSignature(sig);

    console.log(`to: ${to}`);
    console.log(`amount: ${amountWei}`);
    console.log(`nonce: ${nonce}`);
    console.log();
    console.log(`r: ${splitSig.r}`);
    console.log(`s: ${splitSig.s}`);
    console.log(`v: ${splitSig.v}`);
}

signPayment();
