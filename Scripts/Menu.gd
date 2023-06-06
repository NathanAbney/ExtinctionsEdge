extends Node2D

var unlocked = [0,0,0,0]

func _ready():
	Global.boss_rush = false
	MusicController.stop_music()
	Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - vita.png"))
	$StartMenu/Menu/Dinos/BlueDino.disabled = true
	$StartMenu/Menu/Dinos/RedDino.disabled = true
	$StartMenu/Menu/Dinos/YellowDino.disabled = true
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
	Global.health = 6
	Global.current_level = 0
	$Fade.visible = true
	$TransitionPlayer.play("Fade_out")
	$FadeTimer.start()

func _on_fade_timer_timeout():
	if !Global.boss_rush:
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
	$Options/OptionPanel/Code.clear()
