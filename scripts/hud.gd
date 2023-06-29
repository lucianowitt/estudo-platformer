extends CanvasLayer

@onready var score_value := $Margin/Score/Value as Label

var score_points := 0

func _ready():
	score_value.text = str(score_points)

func score_add(value: int):
	score_points += value
	score_value.text = str(score_points)
