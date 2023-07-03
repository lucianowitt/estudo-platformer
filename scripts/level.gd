class_name GameLevel extends Node2D

@onready var player := $Player as Player
@onready var camera := $Camera as Camera2D

func _ready():
	player.follow_camera(camera)
