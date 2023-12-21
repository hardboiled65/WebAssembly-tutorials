const fs = require('fs');

function print_number(num) {
  console.log(num);
}

const wasmCode = fs.readFileSync('./main.wasm');
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, {
  'my_imports': {
    print_number,
  },
});

wasmInstance.exports.main(12345);
