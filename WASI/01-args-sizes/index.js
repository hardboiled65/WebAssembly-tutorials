const { WASI } = require('wasi')
const process = require('process')
const fs = require('fs')

const wasi = new WASI({
  version: 'preview1',
  args: process.argv,
});

const wasmCode = fs.readFileSync('./main.wasm');
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, {
  'wasi_snapshot_preview1': wasi.wasiImport,
});
const memoryBuffer = wasmInstance.exports.memory.buffer;

wasi.start(wasmInstance);

// This must returns 0.
console.log(wasmInstance.exports.main());

// We used 2 pointers. A pointer is 32-bit (4 bytes) size.
const memoryFrag = new Uint8Array(memoryBuffer).slice(0, 8);
console.log(memoryFrag);

