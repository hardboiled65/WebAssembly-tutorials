(module
  ;; Export function add as "add".
  (export "add" (func $add))

  ;; Definition of function add. It takes two integer arguments, and returns an integer.
  (func $add (param $a i32) (param $b i32) (result i32)
    ;; Declare the local variable ret.
    (local $ret i32)
    ;; Set the value of ret as the result of inner parentheses.
    (local.set $ret
      ;; 32-bit integer addition operation.
      (i32.add
        (local.get $a)
        (local.get $b)
      )
    )
    ;; Load the value in ret onto the stack. That value will be returned.
    local.get $ret
  )
)

