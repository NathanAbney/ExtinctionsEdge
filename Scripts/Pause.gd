extends Node2D

func _on_start_pressed():
	get_parent().get_tree().paused = false
	queue_free()

func _on_options_pressed():
	$OptionPanel.visible = true

func _on_exit_pressed():
	get_parent().get_tree().paused = false
	TimeTrack.time = 10000
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_fullscreen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(3)
	else:
		DisplayServer.window_set_mode(0)

func _on_m_vol_value_changed(value):
	var volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume))
