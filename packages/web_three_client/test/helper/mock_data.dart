const abiData = '''
  {
    "abi": [
      {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
      },
      {
        "inputs": [],
        "name": "getName",
        "outputs": [
          {
            "internalType": "string",
            "name": "",
            "type": "string"
          }
        ],
        "stateMutability": "view",
        "type": "function",
        "constant": true
      },
      {
        "inputs": [
          {
            "internalType": "string",
            "name": "newName",
            "type": "string"
          }
        ],
        "name": "setName",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      }
    ],
    "networks": {
      "5777": {
        "address": "0x9823F32D0ed79bE0A40a2E7B0Fb4D30187E6C4ef"
      }
    }
  }
''';

const contractAddress = '0x9823F32D0ed79bE0A40a2E7B0Fb4D30187E6C4ef';

const privateKeyData =
    'd783df9daa3cb906873fdefd8acfad02fd332c2f21ab36a5533f044e1969aa3e';
