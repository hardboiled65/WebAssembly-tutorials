(module
  (import "js_funcs" "log" (func $log (param i32)))

  (export "main" (func $main))

  (func $main (param $num i32)
    ;; Local variable `less_than_32`.
    (local $less_than_32 i32)

    (local.set $less_than_32
      ;; If num is less than 32, then the local variable set to 1, otherwise set to 0.
      (i32.lt_s
        (local.get $num)
        (i32.const 32)
      )
    )
    ;; If `less_than_32` is set to 1 or greater value, it's true.
    (if (local.get $less_than_32)
      ;; If true, run then.
      (then
        (call $log (i32.const 1))
      )
      ;; If false, run else.
      (else
        (call $log (i32.const 0))
      )
    )
  )
)

