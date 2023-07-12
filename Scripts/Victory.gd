extends Node2D

func _ready():
	$CenterContainer/HBoxContainer/VBoxContainer/Text.text = "You Won! \n Total Time: " + str(floor(TimeTrack.time * 100) / 100)
	if Global.dino != null:
		if Global.dino == preload("res://Sprites/DinoSprites - doux.png"):
			$CenterContainer/HBoxContainer/TextureRect.texture = preload("res://Sprites/Blue.png")
		if Global.dino == preload("res://Sprites/DinoSprites - mort.png"):
			$CenterContainer/HBoxContainer/TextureRect.texture = preload("res://Sprites/Red.png")
		if Global.dino == preload("res://Sprites/DinoSprites - tard.png"):
			$CenterContainer/HBoxContainer/TextureRect.texture = preload("res://Sprites/Yellow.png")
		if Global.dino == preload("res://Sprites/DinoSprites - vita.png"):
			$CenterContainer/HBoxContainer/TextureRect.texture = preload("res://Sprites/Green.png")
	else:
		$CenterContainer/HBoxContainer/TextureRect.texture = preload("res://Sprites/Green.png")
	if Global.hat < 15:
		$CenterContainer/HBoxContainer/TextureRect/Hat.visible = true
		$CenterContainer/HBoxContainer/TextureRect/Hat.frame = Global.hat

func _on_exit_pressed():
	get_parent().get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
