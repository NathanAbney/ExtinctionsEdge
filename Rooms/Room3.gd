extends Node2D

var rng = RandomNumberGenerator.new()

func _on_player_1_dead():
	var menu = preload("res://Scenes/game_over.tscn").instantiate()
	menu.scale.x = 1.25
	menu.scale.y = 1.25
	menu.position.x = $Player1.global_position.x - 247
	menu.position.y = $Player1.global_position.y - 161
	add_child(menu)
	get_tree().paused = true

func next_level():
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	rng.randomize()
	var room = rng.randi_range(0,2)
	if room == 0:
		get_tree().change_scene_to_file("res://Rooms/Room4.tscn")
	if room == 1:
		get_tree().change_scene_to_file("res://Rooms/Room5.tscn")
	if room == 2:
		get_tree().change_scene_to_file("res://Rooms/Room6.tscn")
