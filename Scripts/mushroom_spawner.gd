extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize
	var time = rng.randi_range(5,30)
	$Timer.start(time)

func _on_timer_timeout():
	var summon = preload("res://Scenes/mushroom_tiny.tscn").instantiate()
	get_parent().add_child(summon)
	summon.position.x = global_position.x + rng.randf_range(8,20)
	summon.position.y = global_position.y + rng.randf_range(8,20)
	summon.activated = true
	rng.randomize
	var time = rng.randi_range(8,25)
	$Timer.start(time)
