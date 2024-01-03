const fs = require('fs');

const wasmCode = fs.readFileSync('./main.wasm');
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, {});

// Exported Wasm tag.
const tag = wasmInstance.exports.to_js_error;

try {
  // This function throws exception.
  wasmInstance.exports.main();
} catch (e) {
  // e: WebAssembly.Exception.
  console.log(`An exception caught: ${e.getArg(tag, 0)}`);
}

