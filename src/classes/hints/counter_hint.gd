class_name CounterHint
extends MiscellaneousHint
## A special hint, displaying a simple number counter.

const MAX_INCREMENT_BY := 10
const MAX_VALUE := 100
const MIN_INCREMENT_BY := 1
const MIN_VALUE := 0

var increment_by: int = MIN_INCREMENT_BY:
	set(value):
		increment_by = clampi(value, MIN_INCREMENT_BY, MAX_INCREMENT_BY)

var max_value: int = MAX_VALUE:
	set(value):
		max_value = clampi(value, MIN_VALUE, MAX_VALUE)

var min_value: int = MIN_VALUE:
	set(value):
		min_value = clampi(value, MIN_VALUE, MAX_VALUE)
