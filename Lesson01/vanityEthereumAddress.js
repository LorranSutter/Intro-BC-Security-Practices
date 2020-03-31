const ethUtil = require('ethereumjs-util');
const crypto = require('crypto');

function generateKeysAndAddress() {

    // Ensure the private key is valid
    let privateKey = crypto.randomBytes(32);
    while (!ethUtil.isValidPrivate(privateKey)) {
        privateKey = crypto.randomBytes(32);
    }

    // Get the public key based on the private key
    const publicKey = ethUtil.privateToPublic(privateKey);

    // Hash the public key and take the last 20 bytes of the hash
    let address = ethUtil.keccak256(publicKey).slice(12);

    // Encode as hexadecimal
    address = ethUtil.bufferToHex(address);

    return {
        privateKey,
        publicKey,
        address
    }
}

let data = generateKeysAndAddress();
while (data.address.slice(0, 6) !== '0x1234') {
    data = generateKeysAndAddress();
}

console.log(`\nPrivate Key: ${ethUtil.bufferToHex(data.privateKey)}`);
console.log(`Public Key: ${ethUtil.bufferToHex(data.publicKey)}`);
console.log(`Address: ${data.address}\n`);

const myAddress = data.address;
const ethUtilsAddress = ethUtil.bufferToHex(ethUtil.privateToAddress(data.privateKey));

console.log(`Ensure that my generated address is the same as ehtUtils method: ${myAddress === ethUtilsAddress}\n`);