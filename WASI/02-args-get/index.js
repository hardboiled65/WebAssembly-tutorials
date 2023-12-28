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

function u32ToNumber(mem) {
  let n = 0;

  n += mem[0];
  n += mem[1] << (8 * 1);
  n += mem[2] << (8 * 2);
  n += mem[3] << (8 * 3);

  return n;
}

// Arguments end with null character (byte 0).
function printArg(mem) {
  let i = 0;
  while (mem[i] != 0) {
    ++i;
  }
  console.log(new TextDecoder().decode(mem.slice(0, i)));
}

// We used 2 pointers. A pointer is 32-bit (4 bytes) size.
const memoryArgc = new Uint8Array(memoryBuffer).slice(0, 8);
// First of memory, stored argument count.
const argc = u32ToNumber(memoryArgc.slice(0, 4));
// Second of memory, stored total args length.
const total = u32ToNumber(memoryArgc.slice(4, 8));
console.log(`argc: ${argc}`);
console.log(`total length: ${total}`);

const memoryAsArray = new Uint8Array(memoryBuffer);
for (let i = 0; i < argc; ++i) {
  const offset = (8 + (4 * i));
  const pointer = memoryAsArray[offset];
  printArg(memoryAsArray.slice(pointer, pointer + 100));
}

