extends Node2D

func _on_exit_pressed():
	get_parent().get_tree().paused = false
	TimeTrack.time = 10000
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_restart_pressed():
	get_parent().get_parent().get_tree().paused = false
	Global.health = 6
	Global.current_level = 0
	Global.coins = 0
	if !Global.boss_rush:
		MusicController.play_music(1)
		get_tree().change_scene_to_file("res://Rooms/Small/SmallRoom1.tscn")
	else:
		MusicController.play_music(12)
		get_tree().change_scene_to_file("res://Rooms/Boss/Boss3.tscn")
