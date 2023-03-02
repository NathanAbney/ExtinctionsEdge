extends CharacterBody2D

func _on_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(_body):
	$Sprite2D.visible = false
	$Timer.start()
	$CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = true
	$Area2D.monitorable = false

func _physics_process(delta):
	move_and_slide()
