class_name Hud extends CanvasLayer

@onready var score_value := $Margin/VBoxContainer/Score/Value as HBoxContainer
@onready var player_life := $Margin/VBoxContainer/PlayerLife as PlayerLife

var score_points := 0


func _ready():
	score_value.value = score_points


func score_add(value: int):
	score_points += value
	score_value.value = score_points


func add_heart():
	player_life.add_heart()


func remove_heart():
	player_life.remove_heart()
