(module
  (export "main" (func $main))
  (export "to_js_error" (tag $to_js_error))

  (tag $basic_error (param i32))
  (tag $to_js_error (param i32))

  ;; Throw basic_error exception.
  (func $throw_exception
    (throw $basic_error (i32.const 12))
  )

  ;; Throw to_js_error exception.
  (func $no_catch
    (throw $to_js_error (i32.const 24))
  )

  (func $main
    ;; Try-catch.
    (try
      (do
        ;; Call the function that throws `basic_error` exception.
        (call $throw_exception)
      )
      (catch $basic_error
        ;; Drop the exception argument.
        (drop)
      )
    )
    ;; Raise the exception and pass it to JavaScript side.
    (call $no_catch)
  )
)
