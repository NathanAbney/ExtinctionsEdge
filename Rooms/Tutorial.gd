extends Node2D

var rng = RandomNumberGenerator.new()
var activated = false

func _ready():
	$Player1.sethealth(6)
	Global.coins = 50
	MusicController.play_music(7)
	if Global.dark_mode:
		get_node("Darken").color = Color(0,0,0)

func _on_player_1_dead():
	$Player1.sethealth(6)

func next_level():
	if !activated:
		activated = true
		$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start(.2)

func _on_timer_timeout():
	$AnimationPlayer.play("Fade_in")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Fade_in":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
