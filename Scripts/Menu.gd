extends Node2D

func _ready():
	Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - vita.png"))
	$StartMenu/Menu/Dinos/BlueDino.disabled = true
	$StartMenu/Menu/Dinos/RedDino.disabled = true
	$StartMenu/Menu/Dinos/YellowDino.disabled = true
	
	#grab focus of the start button
	$Menu/Box/Start.grab_focus()

func _on_start_pressed():
	$Menu.visible = false
	$StartMenu.visible = true

func _physics_process(delta):
	$Path2D/PathFollow2D.progress = $Path2D/PathFollow2D.progress + 25 * delta

func _on_options_pressed():
	$Options.visible = true
	$Menu.visible = false
	pass # Options go here

func _on_credits_pressed():
	pass # Credits will go here

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
	$Fade.visible = true
	$TransitionPlayer.play("Fade_out")
	$FadeTimer.start()

func _on_fade_timer_timeout():
	get_tree().change_scene_to_file("res://Rooms/Room1.tscn")

func _on_back_pressed():
	if $Options.visible:
		$Options.visible = false
	if $StartMenu.visible:
		$StartMenu.visible = false
	$Menu.visible = true

func _on_fullscreen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(3)
	else:
		DisplayServer.window_set_mode(0)

func _on_discord_pressed():
	# OS.shell_open("https://discord.gg/mNXaP7dzhR")
	Global.hat = 1

# Cheat Codes

func _on_code_text_submitted(new_text):
	if new_text == "BARNEY":
		Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - purp.png"))
		$Options/OptionPanel/Code.clear()
	if new_text == "WEENIEHUT":
		$StartMenu/Menu/Dinos/BlueDino.disabled = false
		$StartMenu/Menu/Dinos/RedDino.disabled = false
		$StartMenu/Menu/Dinos/YellowDino.disabled = false
		$Options/OptionPanel/Code.clear()
	if new_text == "GENES1S":
		Global.god_mode = true
		$Options/OptionPanel/Code.clear()

