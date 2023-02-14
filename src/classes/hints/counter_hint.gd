class_name CounterHint
extends Hint

const INCREMENT_BY := 1
const MAX_VALUE := 100
const MIN_VALUE := 0

var increment_by: int = INCREMENT_BY
var max_value: int = MAX_VALUE
var min_value: int = MIN_VALUE


func is_pinned() -> bool:
	return true
