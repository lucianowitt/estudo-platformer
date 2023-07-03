class_name PlayerLife extends HBoxContainer

const MAX_HEARTS := 5

var hearts := MAX_HEARTS


func _ready():
	update_hearts()


func remove_heart():
	if hearts > 0:
		hearts -= 1
		update_hearts()


func add_heart():
	if hearts < MAX_HEARTS:
		hearts += 1
		update_hearts()


func update_hearts():
	var i = 1
	for child in get_children():
		var heart := child as Control
		heart.visible = (i <= hearts)
		i += 1
