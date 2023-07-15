extends Node2D

func _ready():
	if Global.supersmall:
		$Player1.scale = Vector2(.5,.5)
	Global.current_level = Global.current_level + 1
	$Player1.health = Global.health
	if Global.dark_mode:
		get_node("Darken").color = Color(0,0,0)

func _on_player_1_dead():
	var menu = preload("res://Scenes/game_over.tscn").instantiate()
	menu.scale.x = 1.25
	menu.scale.y = 1.25
	menu.position.x = $Player1.global_position.x - 247
	menu.position.y = $Player1.global_position.y - 161
	add_child(menu)
	get_tree().paused = true

func next_level():
	if !Global.boss_rush:
		Global.coins = Global.coins + 20
	else:
		Global.coins = Global.coins + 20
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	if !Global.boss_rush:
		Global.game_beat = true
		$Player1.win()
	else:
		Global.change_next_level()
		get_tree().change_scene_to_file(Global.next_level)

func camera_zoom():
	$Player1/Camera2D.zoom.x = .5
	$Player1/Camera2D.zoom.y = .5
