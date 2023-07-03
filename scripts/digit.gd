class_name Digit extends Control

const DIGIT_REGIONS := [
	Rect2(16, 0, 8, 8), Rect2(24, 0, 8, 8), Rect2(32, 0, 8, 8), Rect2(40, 0, 8, 8), Rect2(48, 0, 8, 8),
	Rect2(16, 8, 8, 8), Rect2(24, 8, 8, 8), Rect2(32, 8, 8, 8), Rect2(40, 8, 8, 8), Rect2(48, 8, 8, 8)
]

@onready var texture := $Texture as Sprite2D

@export_range(0, 9) var value := 0 :
	set(v):
		value = v
		update_texture()
	get:
		return value


func _ready():
	update_texture()


func update_texture():
	texture.region_rect = DIGIT_REGIONS[value]

