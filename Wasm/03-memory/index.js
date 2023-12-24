const fs = require('fs');

const wasmCode = fs.readFileSync('./main.wasm');
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, {});

const memoryBuffer = wasmInstance.exports.memory.buffer;

// Call the main function. It writes to the value 1234 to the memory offset 0.
wasmInstance.exports.main();

const bytes = new Uint8Array(memoryBuffer).slice(0, 4);

console.log(bytes);

// In this tutorial we will handle the memory value as unsigned integer value
// because the value 1234 not exceed the bound of maximum value can represent
// the positive number. The result will be same.
// Since Wasm stores value to memory in little-endian, the last byte is higher.
function u32ToNumber(uint8Array) {
  let n = 0;

  n += uint8Array[0] << (0);
  n += uint8Array[1] << (1 * 8);
  n += uint8Array[2] << (2 * 8);
  n += uint8Array[3] << (3 * 8);

  return n;
}

// This will prints 1234.
console.log(u32ToNumber(bytes));

