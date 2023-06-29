extends CharacterBody2D
class_name Enemy

enum Directions { LEFT, RIGHT }

const JUMP_VELOCITY := -200.0
const PLAYER_LAYER := 1
const WORLD_LAYER := 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var texture := $Texture as Sprite2D
@onready var animation := $Animation as AnimationPlayer
@onready var walk_collider := $WalkCollider as RayCast2D

@export var walk_speed := 2000.0
@export var walk_direction := Directions.LEFT


func _ready():
	if walk_direction == Directions.RIGHT:
		flip()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if walk_collider.is_colliding():
		change_direction()
		flip()
	
	var direction_value = -1.0 if walk_direction == Directions.LEFT else 1.0
	
	velocity.x = delta * walk_speed * direction_value
	
	move_and_slide()


func change_direction():
	if walk_direction == Directions.LEFT:
		walk_direction = Directions.RIGHT
	else:
		walk_direction = Directions.LEFT


func flip():
	walk_collider.scale.x *= -1.0
	texture.flip_h = not texture.flip_h


func hurt():
	disable_collision_with(PLAYER_LAYER)
	animation.play("hurt")
	velocity.y = JUMP_VELOCITY
	disable_collision_with(WORLD_LAYER)


func disable_collision_with(layer: int):
	set_collision_mask_value(layer, false)


func _on_animation_animation_finished(anim_name):
	if anim_name == "hurt":
		queue_free()
