extends Node2D

func _on_timer_timeout():
	$Sprite2D.frame = 353
	$Area2D/CollisionShape2D.disabled = false

func _on_area_2d_area_entered(area):
	$Sprite2D.frame = 356
	$Timer.start()
	$Area2D/CollisionShape2D.disabled = true

