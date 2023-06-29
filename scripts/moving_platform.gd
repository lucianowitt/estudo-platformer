extends Node2D

const TILE_SIZE := 16.0

@onready var platform := $Platform as AnimatableBody2D

@export var moves_horizontally := true
@export var speed := 3.0
@export var distance := 4
@export var wait := 2.0

var follow := Vector2.ZERO
var platform_center := 1.0 * TILE_SIZE


func _ready() -> void:
	move_platform()


func _process(_delta) -> void:
	platform.position = platform.position.lerp(follow, 0.5)


func move_platform() -> void:
	var direction := Vector2.RIGHT if moves_horizontally else Vector2.UP
	direction *= distance * TILE_SIZE
	
	var duration := direction.length() / float(speed * platform_center)
	
	var platform_tween := create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	platform_tween.tween_property(self, "follow", direction, duration).set_delay(wait)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(wait)
