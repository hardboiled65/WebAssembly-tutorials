const fs = require('fs');

function printIndex(i32) {
  console.log(`loop index: ${i32}`);
}

const wasmCode = fs.readFileSync('./main.wasm')
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, {
  'js_funcs': { 'print_index': printIndex },
});

wasmInstance.exports.main();

