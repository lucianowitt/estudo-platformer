class_name Score extends HBoxContainer

var digits := []

@export var value := 0 :
	set(v):
		value = v
		update_score()

func _ready():
	digits = get_children()
	update_score()


func update_score():
	var index := digits.size()
	var v := value
	while index > 0:
		index -= 1
		(digits[index] as Digit).value = v % 10
		v = int(float(v) / 10.0)
