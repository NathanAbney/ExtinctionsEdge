extends VBoxContainer

func _on_start_pressed():
	get_parent().get_parent().get_tree().paused = false
	Global.health = 6
	Global.current_level = 0
	get_tree().change_scene_to_file("res://Rooms/Small/SmallRoom1.tscn")

func _on_exit_pressed():
	get_parent().get_parent().get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
