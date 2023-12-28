(module
  ;; Import WASI functions.
  (import "wasi_snapshot_preview1" "args_sizes_get" (func $args_sizes_get (param i32 i32)
    (result i32)))
  (import "wasi_snapshot_preview1" "args_get" (func $args_get (param i32 i32)
    (result i32)))

  ;; Memory to export.
  (memory $memory 1)

  ;; Export memory.
  (export "memory" (memory $memory))
  ;; Export main function.
  (export "main" (func $main))
  (export "_start" (func $_start))

  (func $main (result i32)
    ;; Local variable to get error code.
    (local $err i32)
    (local $argc i32)

    ;; Set vairiable err from the return value of args_sizes_get function.
    (local.set $err
      ;; Call function with pointer 0 and 4 of the memory.
      (call $args_sizes_get
        (i32.const 0)
        (i32.const 4)
      )
    )

    ;; If the error code is not 0, return 1.
    (if (i32.ne (i32.const 0) (local.get $err))
      (then
        (return (i32.const 1))
      )
    )

    ;; Set variable args to number of arguments.
    (local.set $argc
      (i32.load (i32.const 0))
    )

    ;; Set variable err from the return value of args_get function.
    (local.set $err
      (call $args_get
        (i32.const 8) ;; Memory offset we didn't used yet.
        (i32.add      ;; Memory offset where the argument data written.
          (i32.const 8)
          (i32.mul (local.get $argc) (i32.const 4))
        )
      )
    )

    ;; If the error code is not 0, return 1.
    (if (i32.ne (i32.const 0) (local.get $err))
      (then
        (return (i32.const 1))
      )
    )

    ;; On success, return 0.
    (return (i32.const 0))
  )

  ;; WASI needs _start function to run.
  (func $_start
  )
)

