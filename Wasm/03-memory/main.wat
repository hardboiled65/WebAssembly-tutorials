(module
  ;; Memory, initial size 1.
  (memory $memory 1)

  ;; Export memory.
  (export "memory" (memory $memory))
  (export "main" (func $main))

  (func $main
    (i32.store
      ;; The offset of memory.
      (i32.const 0)
      ;; The value to store.
      (i32.const 1234)
    )
  )
)

