extends Node2D

func _ready():
	Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - vita.png"))
	$StartMenu/Dinos/BlueDino.disabled = true
	$StartMenu/Dinos/RedDino.disabled = true
	$StartMenu/Dinos/YellowDino.disabled = true

func _on_start_pressed():
	$Menu.visible = false
	$StartMenu.visible = true

func _physics_process(delta):
	$Path2D/PathFollow2D.progress = $Path2D/PathFollow2D.progress + 25 * delta

func _on_options_pressed():
	pass # Options go here

func _on_credits_pressed():
	pass # Credits will go here

func _on_exit_pressed():
	get_tree().quit()

func _on_red_dino_pressed():
	if $StartMenu/Dinos/RedDino.disabled == false:
		Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - mort.png"))

func _on_blue_dino_pressed():
	if $StartMenu/Dinos/BlueDino.disabled == false:
		Global.dino = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/DinoSprites - doux.png"))

func _on_yellow_dino_pressed():
	if $StartMenu/Dinos/YellowDino.disabled == false:
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
