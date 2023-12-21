(module
  ;; Declare imported function print_number from namespace "my_imports".
  ;; The function gets single i32 argument and returns nothing.
  (import "my_imports" "print_number" (func $print_number (param i32)))
  (export "main" (func $main))

  (func $main (param $num i32)
    (call $print_number (local.get $num))
  )
)

