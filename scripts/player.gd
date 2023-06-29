extends CharacterBody2D
class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D
@onready var remote_cam := $RemoteCamera as RemoteTransform2D

@onready var knock_left := $KnockLeft as RayCast2D
@onready var knock_right := $KnockRight as RayCast2D

@export var player_life := 10
var knock_back_vector := Vector2.ZERO


func _ready():
	print("player ready")


func _physics_process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		fall(delta)

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
		
		if is_on_floor():
			animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animation.play("idle")
	
	if knock_back_vector != Vector2.ZERO:
		velocity = knock_back_vector
	
	move_and_slide()


func fall(delta: float):
	velocity.y += gravity * delta
	animation.play("jump")


func jump():
	velocity.y = JUMP_VELOCITY


func _on_hurtbox_body_entered(body):
	if body is Enemy:
		if player_life <= 0:
			queue_free()
		else:
			var knock_back_force = Vector2.ZERO
			if knock_left.is_colliding():
				knock_back_force = Vector2(200, -200)
			elif knock_right.is_colliding():
				knock_back_force = Vector2(-200, -200)
			
			take_damage(knock_back_force)


func take_damage(knock_back_force := Vector2.ZERO, duration := 0.25):
	player_life -= 1
	if knock_back_force != Vector2.ZERO:
		knock_back_vector = knock_back_force
		
		var knock_back_tween := get_tree().create_tween()
		knock_back_tween.parallel().tween_property(self, "knock_back_vector", Vector2.ZERO, duration)
		
		animation.modulate = Color.RED
		knock_back_tween.parallel().tween_property(animation, "modulate", Color.WHITE, duration)

func follow_camera(camera: Camera2D):
	remote_cam.remote_path = camera.get_path()
