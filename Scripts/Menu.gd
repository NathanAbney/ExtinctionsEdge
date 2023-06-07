extends Node2D

var BlueUnlocked = false
var RedUnlocked = false
var YellowUnlocked = false
var wins : int = 0
var record : float = 9999.99

func load_user_data():
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error != OK:
		print("No save data found")
		create_save()
	else:
		print("Save data found")
		BlueUnlocked = config.get_value("Characters","BlueDino",false)
		RedUnlocked = config.get_value("Characters","RedDino",false)
		YellowUnlocked = config.get_value("Characters","YellowDino",false)
		var wins = config.get_value("Stats","Wins",0)
		$Options/Wins.text = "Wins: " + str(wins)
		var record = config.get_value("Stats","Record",9999.99)
		$Options/Record.text = "Record: " + str(record)

func create_save():
	var config = ConfigFile.new()
	config.set_value("Characters","BlueDino",false)
	config.set_value("Characters","RedDino",false)
	config.set_value("Characters","YellowDino",false)
	config.set_value("Stats","Wins",0)
	config.set_value("Stats","Record",99999.99)
	var error = config.save("user://character_unlock.cfg")
	if error == OK:
		print("Save data created successfully!")
	else:
		print("Failed to create save data")

func update_save():
	var config = ConfigFile.new()
	var error = config.load("user://character_unlock.cfg")
	if error == OK:
		print("Save data loaded successfully!")
		if !Global.god_mode:
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
			var saveError = config.save("user://character_unlock.cfg")
			if saveError != OK:
				print("Failed to update save")
		else:
			create_save()
	load_user_data()

func delete_save():
	var config = ConfigFile.new()
	var loadError = config.load("user://character_unlock.cfg")
	if loadError != OK:
		print("Error loading save file")
	config.clear()
	update_save()

func _ready():
	Global.coins = 0
	TimeTrack.stop_clock()
	MusicController.stop_music()
	update_save()
	Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - vita.png"))
	$StartMenu/Menu/Dinos/BlueDino.disabled = !BlueUnlocked
	$StartMenu/Menu/Dinos/RedDino.disabled = !RedUnlocked
	$StartMenu/Menu/Dinos/YellowDino.disabled = !YellowUnlocked
	Global.hat = 0

func _on_start_pressed():
	$Menu.visible = false
	$StartMenu.visible = true
	$"StartMenu/Hat Selection/Container/Sprite2D".frame = Global.hat

func _on_boss_rush_pressed():
	Global.boss_rush = true
	_on_start_pressed()
	$"StartMenu/Hat Selection/Container/Sprite2D".frame = Global.hat

func _physics_process(delta):
	$Path2D/PathFollow2D.progress = $Path2D/PathFollow2D.progress + 25 * delta

func _on_options_pressed():
	$Options.visible = true
	$Menu.visible = false

func _on_credits_pressed():
	$Menu.visible = false
	$Credits.visible = true

func _on_exit_pressed():
	get_tree().quit()

func _on_red_dino_pressed():
	if $StartMenu/Menu/Dinos/RedDino.disabled == false:
		Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - mort.png"))

func _on_blue_dino_pressed():
	if $StartMenu/Menu/Dinos/BlueDino.disabled == false:
		Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - doux.png"))

func _on_yellow_dino_pressed():
	if $StartMenu/Menu/Dinos/YellowDino.disabled == false:
		Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - tard.png"))

func _on_green_dino_pressed():
	Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - vita.png"))

func _on_begin_pressed():
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
		MusicController.play_music(2)
		get_tree().change_scene_to_file("res://Rooms/Boss/Boss4.tscn")

func _on_back_pressed():
	if $Options.visible:
		$Options.visible = false
	if $Credits.visible:
		$Credits.visible = false
	if $StartMenu.visible:
		$StartMenu.visible = false
	$Menu.visible = true

func _on_fullscreen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(3)
	else:
		DisplayServer.window_set_mode(0)

func _on_discord_pressed():
	OS.shell_open("https://discord.gg/mNXaP7dzhR")

# Cheat Codes

func _on_code_text_submitted(new_text):
	if new_text == "BARNEY":
		Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - purp.png"))
	if new_text == "WEENIEHUT":
		$StartMenu/Menu/Dinos/BlueDino.disabled = false
		$StartMenu/Menu/Dinos/RedDino.disabled = false
		$StartMenu/Menu/Dinos/YellowDino.disabled = false
	if new_text == "GENES1S":
		Global.god_mode = true
	if new_text == "CLEARSAVE":
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
