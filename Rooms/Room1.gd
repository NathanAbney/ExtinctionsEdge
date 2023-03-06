extends Node2D

var rng = RandomNumberGenerator.new()

func _on_player_1_dead():
	var menu = preload("res://Scenes/game_over.tscn").instantiate()
	menu.scale.x = 1.25
	menu.scale.y = 1.25
	menu.position.x = $Player1.global_position.x - 247
	menu.position.y = $Player1.global_position.y - 161
	add_child(menu)
	get_tree().paused = true

func next_level():
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Rooms/Room3.tscn")
