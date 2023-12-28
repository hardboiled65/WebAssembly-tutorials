(module
  (import "js_funcs" "print_index" (func $print_index (param i32)))

  (export "main" (func $main))

  (func $main
    ;; Local variable index.
    (local $index i32)

    ;; Set index to 0.
    (local.set $index (i32.const 0))

    ;; Start loop.
    (loop $my_loop
      ;; Print current index.
      (call $print_index
        (local.get $index)
      )
      ;; Index increase 1.
      (local.set $index
        (i32.add
          (local.get $index)
          (i32.const 1)
        )
      )
      ;; `br_if` loops if condition is true, otherwise stop the loop.
      (br_if $my_loop
        ;; if (index < 20)
        (i32.lt_s (local.get $index) (i32.const 20))
      )
    )
  )
)

