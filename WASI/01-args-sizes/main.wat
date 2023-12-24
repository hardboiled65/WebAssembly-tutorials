(module
  ;; Import args_sizes_get function.
  (import "wasi_snapshot_preview1" "args_sizes_get" (func $args_sizes_get (param i32 i32)
    (result i32)))

  ;; Memory to export.
  (memory $memory 1)

  ;; Export memory.
  (export "memory" (memory $memory))
  ;; Export main function.
  (export "main" (func $main))
  (export "_start" (func $_start))

  (func $main (result i32)
    ;; Local variable to return.
    (local $ret i32)

    ;; Set vairiable ret from the return value of args_sizes_get function.
    (local.set $ret
      ;; Call function with pointer 0 and 4 of the memory.
      (call $args_sizes_get
        (i32.const 0)
        (i32.const 4)
      )
    )
    (local.get $ret)
  )

  ;; WASI needs _start function to run.
  (func $_start
  )
)

