extends CharacterBody2D

func _ready():
	$AnimationPlayer.play("Idle")
	$Timer.start()

func _on_timer_timeout():
	queue_free()
