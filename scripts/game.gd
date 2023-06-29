extends Node

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		get_tree().quit()
	elif event.is_action("ui_home"):
		get_tree().reload_current_scene()
