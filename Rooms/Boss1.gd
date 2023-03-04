extends Node2D

func _on_player_1_dead():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func next_level():
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	print("Game won!")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func camera_zoom():
	$Player1/Camera2D.zoom.x = .5
	$Player1/Camera2D.zoom.y = .5
