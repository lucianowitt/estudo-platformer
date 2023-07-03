class_name Game extends Node

@onready var hud := $HUD as Hud

var default_gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float

var levels := []
var current_level_index := -1
var current_level : GameLevel = null
var player : Player = null

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	for child in get_children():
		if child is GameLevel:
			levels.append(child)
	
	load_next_level()


func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		get_tree().quit()
	elif event.is_action("ui_home"):
		get_tree().reload_current_scene()


func load_next_level():
	if current_level_index < levels.size() - 1:
		current_level_index += 1
		current_level = levels[current_level_index]
		player = current_level.player
		hud.player_life.hearts = player.player_life
		hud.player_life.update_hearts()
