extends Area2D


func _on_body_entered(body):
	if body is Player:
		var player = body as Player
		player.jump()
		
	if owner is Enemy:
		var enemy = owner as Enemy
		enemy.hurt()
