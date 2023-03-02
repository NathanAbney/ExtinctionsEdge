extends Node2D

var rng = RandomNumberGenerator.new()

func _on_player_1_dead():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func next_level():
	rng.randomize()
	var level = rng.randi_range(0,1)
	if level == 1:
		get_tree().change_scene_to_file("res://Rooms/Room2.tscn")
	if level == 0:
		get_tree().change_scene_to_file("res://Rooms/Room4.tscn")
