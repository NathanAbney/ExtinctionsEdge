extends VBoxContainer

func _on_start_pressed():
	get_parent().get_parent().get_parent().get_tree().paused = false
	get_parent().visible = false

func _on_options_pressed():
	pass # Options go here

func _on_exit_pressed():
	get_parent().get_parent().get_parent().get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
