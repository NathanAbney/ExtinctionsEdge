extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	$Player1.sethealth(6)
	print("tutorial")
	Global.coins = 50

func _on_player_1_dead():
	$Player1.sethealth(6)

func next_level():
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
