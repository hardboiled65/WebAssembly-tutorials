const fs = require('fs');

const wasmCode = fs.readFileSync('./main.wasm')
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, {
  'js_funcs': { 'log': console.log },
});

wasmInstance.exports.main(31); // This will print 1.
wasmInstance.exports.main(32); // This will print 0.

