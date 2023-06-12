extends Node2D

var up : bool = true

func _physics_process(delta):
	if up:
		$Sprite2D.position.y += (9 * delta)
		$Area2D.position.y += (9 * delta)
		if $Sprite2D.position.y >= -40:
			up = false
	else:
		$Sprite2D.position.y -= (9 * delta)
		$Area2D.position.y -= (9 * delta)
		if $Sprite2D.position.y <= -50:
			up = true
