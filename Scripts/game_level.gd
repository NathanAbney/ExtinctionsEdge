extends Node2D


func _on_player_1_dead():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	$Player1/Life.update(6)
