const fs = require('fs');

const wasmCode = fs.readFileSync('./main.wasm')
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, {});

console.log(wasmInstance.exports.add(222, 444));

