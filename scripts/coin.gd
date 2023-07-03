extends Area2D

@onready var animation := $AnimatedSprite2D

@onready var hud = get_node("/root/Game/HUD") as Hud

@export var points := 10

var collected := false


func _on_body_entered(body: Node2D):
	if not collected:
		if body is Player:
			collected = true
			animation.play("collect")
			hud.score_add(points)


func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "collect":
		queue_free()
