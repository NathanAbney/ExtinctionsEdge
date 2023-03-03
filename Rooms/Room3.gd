extends Node2D

var rng = RandomNumberGenerator.new()

func _on_player_1_dead():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func next_level():
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Rooms/Room2.tscn")
