extends Node2D

func _on_timer_timeout():
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error != OK:
		get_tree().change_scene_to_file("res://Rooms/Tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
