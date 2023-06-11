extends Node2D

func _ready():
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error == OK:
		if !config.get_value("Settings","Fullscreen",true):
			DisplayServer.window_set_mode(0)
		else:
			DisplayServer.window_set_mode(3)
		var volume = config.get_value("Settings","Volume",0.8)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume))
	if error != OK:
		DisplayServer.window_set_mode(3)
	MusicController.play_music(6)

func _process(delta):
	if (Input.is_action_just_pressed("Space")):
		MusicController.stop_music()
		_on_timer_timeout()

func _on_timer_timeout():
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error != OK:
		get_tree().change_scene_to_file("res://Rooms/Tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
