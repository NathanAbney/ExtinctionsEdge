extends Node2D

var BlueUnlocked = false
var RedUnlocked = false
var YellowUnlocked = false
var fullscreen
var wins : int = 0
var record : float = 9999.99
var username
var volume

func load_user_data():
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error != OK:
		print("No save data found")
		create_save()
	else:
		print("Save data found")
		fullscreen = config.get_value("Settings","Fullscreen",true)
		volume = config.get_value("Settings","Volume",0.8)
		BlueUnlocked = config.get_value("Characters","BlueDino",false)
		RedUnlocked = config.get_value("Characters","RedDino",false)
		YellowUnlocked = config.get_value("Characters","YellowDino",false)
		wins = config.get_value("Stats","Wins",0)
		$Options/Wins.text = "Wins: " + str(wins)
		record = config.get_value("Stats","Record",9999.99)
		$Options/Record.text = "Record: " + str(record)
		username = config.get_value("Stats","Name","false")
		print(volume)
		$Options/OptionPanel/MasterVol/MVol.value = volume
		if !fullscreen:
			$Options/OptionPanel/Fullscreen.button_pressed = false
			DisplayServer.window_set_mode(0)
		print(config.get_value("Stats","Name","false"))

func create_save():
	var config = ConfigFile.new()
	config.set_value("Characters","BlueDino",false)
	config.set_value("Characters","RedDino",false)
	config.set_value("Characters","YellowDino",false)
	config.set_value("Stats","Wins",0)
	config.set_value("Stats","Record",9999)
	config.set_value("Stats","Name","Dino" + str(randi_range(10000,99999)))
	config.set_value("Settings","Fullscreen",true)
	config.set_value("Settings","Volume",0.8)
	DisplayServer.window_set_mode(3)
	var error = config.save("user://character_unlock.cfg")
	if error == OK:
		print("Save data created successfully!")
	else:
		print("Failed to create save data")

func update_save():
	load_user_data()
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error == OK:
		print("Save data loaded successfully!")
		if Global.boss_rush_beaten:
			print("Blue Dino Unlocked")
			config.set_value("Characters","BlueDino",true)
		if Global.no_hit && Global.game_beat:
			print("Red Dino Unlocked")
			config.set_value("Characters","RedDino",true)
		if Global.game_beat:
			print("Yellow Dino Unlocked")
			config.set_value("Characters","YellowDino",true)
			config.set_value("Stats","Wins", wins + 1)
		if TimeTrack.time < record:
			config.set_value("Stats","Record",TimeTrack.time)
		TimeTrack.time = 0
		var saveError = config.save("user://character_unlock.cfg")
		if saveError != OK:
			print("Failed to update save")
	else:
		create_save()
	load_user_data()

func update_settings():
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error == OK:
		config.set_value("Settings","Fullscreen",fullscreen)
		config.set_value("Settings","Volume",volume)
		var saveError = config.save("user://character_unlock.cfg")

func delete_save():
	var config = ConfigFile.new()
	var loadError = config.load("user://character_unlock.cfg")
	if loadError != OK:
		print("Error loading save file")
	config.clear()
	update_save()

func _ready():
	MusicController.able = true
	Global.cheat_song = false
	Global.dark_mode = false
	Global.coins = 0
	Global.boss_rush = false
	TimeTrack.stop_clock()
	MusicController.stop_music()
	update_save()
	Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - vita.png"))
	$StartMenu/Menu/Dinos/BlueDino.disabled = !BlueUnlocked
	$StartMenu/Menu/Dinos/RedDino.disabled = !RedUnlocked
	$StartMenu/Menu/Dinos/YellowDino.disabled = !YellowUnlocked
	Global.hat = 0
	MusicController.play_music(8)
	$AnimationPlayer.play("Fade_in")

func _on_start_pressed():
	MusicController.play_sound(12)
	$Menu.visible = false
	$StartMenu.visible = true
	$"StartMenu/Hat Selection/Container/Sprite2D".frame = Global.hat

func _on_boss_rush_pressed():
	MusicController.play_sound(12)
	Global.boss_rush = true
	_on_start_pressed()
	$"StartMenu/Hat Selection/Container/Sprite2D".frame = Global.hat

func _physics_process(delta):
	$Path2D/PathFollow2D.progress = $Path2D/PathFollow2D.progress + 25 * delta

func _on_options_pressed():
	MusicController.play_sound(12)
	$Options.visible = true
	$Menu.visible = false

func _on_credits_pressed():
	MusicController.play_sound(12)
	$Menu.visible = false
	$Credits.visible = true

func _on_exit_pressed():
	get_tree().quit()

func _on_red_dino_pressed():
	if $StartMenu/Menu/Dinos/RedDino.disabled == false:
		MusicController.play_sound(14)
		Global.dino = preload("res://Sprites/DinoSprites - mort.png")

func _on_blue_dino_pressed():
	if $StartMenu/Menu/Dinos/BlueDino.disabled == false:
		MusicController.play_sound(14)
		Global.dino = preload("res://Sprites/DinoSprites - doux.png")

func _on_yellow_dino_pressed():
	if $StartMenu/Menu/Dinos/YellowDino.disabled == false:
		MusicController.play_sound(14)
		Global.dino = preload("res://Sprites/DinoSprites - tard.png")

func _on_green_dino_pressed():
	MusicController.play_sound(14)
	Global.dino = preload("res://Sprites/DinoSprites - vita.png")

func _on_begin_pressed():
	MusicController.play_sound(14)
	Global.boss_rush_beaten = false
	Global.health = 6
	Global.current_level = 0
	Global.no_hit = true
	Global.game_beat = false
	$Fade.visible = true
	$TransitionPlayer.play("Fade_out")
	$FadeTimer.start()

func _on_fade_timer_timeout():
	if !Global.boss_rush:
		TimeTrack.start_clock()
		MusicController.play_music(1)
		get_tree().change_scene_to_file("res://Rooms/Small/SmallRoom1.tscn")
	else:
		MusicController.play_music(12)
		get_tree().change_scene_to_file("res://Rooms/Boss/Boss3.tscn")

func _on_back_pressed():
	MusicController.play_sound(13)
	if $Options.visible:
		update_settings()
		$Options.visible = false
	if $Credits.visible:
		$Credits.visible = false
	if $StartMenu.visible:
		$StartMenu.visible = false
	Global.boss_rush = false
	$Menu.visible = true

func _on_fullscreen_toggled(button_pressed):
	MusicController.play_sound(11)
	if button_pressed:
		fullscreen = true
		DisplayServer.window_set_mode(3)
	else:
		fullscreen = false
		DisplayServer.window_set_mode(0)

func _on_discord_pressed():
	MusicController.play_sound(14)
	OS.shell_open("https://discord.gg/mNXaP7dzhR")

# Cheat Codes

func _on_code_text_submitted(new_text):
	if new_text == "BARNEY":
		MusicController.play_sound(14)
		Global.dino = preload("res://Sprites/DinoSprites - purp.png")
	if new_text == "WEENIEHUT":
		MusicController.play_sound(14)
		$StartMenu/Menu/Dinos/BlueDino.disabled = false
		$StartMenu/Menu/Dinos/RedDino.disabled = false
		$StartMenu/Menu/Dinos/YellowDino.disabled = false
	if new_text == "GENES1S":
		MusicController.play_sound(14)
		Global.god_mode = true
	if new_text == "CLEARSAVE":
		MusicController.play_sound(14)
		Global.boss_rush_beaten = false
		create_save()
		load_user_data()
		$StartMenu/Menu/Dinos/BlueDino.disabled = !BlueUnlocked
		$StartMenu/Menu/Dinos/RedDino.disabled = !RedUnlocked
		$StartMenu/Menu/Dinos/YellowDino.disabled = !YellowUnlocked
	if new_text == "EDGEOFEXTINCTION":
		MusicController.play_sound(14)
		MusicController.play_music(5)
		Global.cheat_song = true
	if new_text == "DINOSAURSOUP":
		MusicController.play_sound(14)
		MusicController.play_music(9)
		Global.cheat_song = true
	if new_text == "CURSE":
		MusicController.play_sound(14)
		MusicController.play_music(10)
		Global.cheat_song = true
	if new_text == "ENEMYSWAG":
		MusicController.play_sound(14)
		Global.enemy_hats = true
	if new_text == "DARKSCARYTIME":
		MusicController.play_sound(14)
		Global.dark_mode = true
	if new_text == "NATHANSCODE":
		MusicController.play_sound(5)
		Global.QRActive = true
	if new_text == "SENDMENUDES":
		MusicController.play_sound(14)
		MusicController.play_music(13)
		$MonkeySmirk.visible = true
		$MonkeySmirk/Timer.start()
		Global.boss_rush_beaten = false
		create_save()
		load_user_data()
		$StartMenu/Menu/Dinos/BlueDino.disabled = !BlueUnlocked
		$StartMenu/Menu/Dinos/RedDino.disabled = !RedUnlocked
		$StartMenu/Menu/Dinos/YellowDino.disabled = !YellowUnlocked
	$Options/OptionPanel/Code.clear()

func _on_stat_pressed():
	$Options/Wins.visible = true
	$Options/Record.visible = true

func _on_m_vol_value_changed(value):
	volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume))

func _on_itch_pressed():
	MusicController.play_sound(14)
	OS.shell_open("https://costellae-studios.itch.io/")

func _on_timer_timeout():
	get_tree().quit()
