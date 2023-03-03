extends Node2D

var rng = RandomNumberGenerator.new()

func _on_player_1_dead():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func next_level():
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	rng.randomize()
	var room = rng.randi_range(0,1)
	if room == 0:
		get_tree().change_scene_to_file("res://Rooms/Room4.tscn")
	if room == 1:
		get_tree().change_scene_to_file("res://Rooms/Room3.tscn")
