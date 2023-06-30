extends Node2D

var wave : int = 0
var started : bool = false
var rng = RandomNumberGenerator.new()
var remaining : int = 0

func _ready():
	print("Global health: " + str(Global.health))
	Global.current_level = Global.current_level + 1
	MusicController.play_music(4)

func _on_player_1_dead():
	var menu = preload("res://Scenes/game_over.tscn").instantiate()
	menu.scale.x = 1.25
	menu.scale.y = 1.25
	menu.position.x = $Player1.global_position.x - 247
	menu.position.y = $Player1.global_position.y - 161
	add_child(menu)
	get_tree().paused = true

func wave_completed():
	wave = wave + 1
	if wave == 6:
		completed()
	else:
		var wavepower = wave * wave + 3
		while(wavepower > 0):
			var enemy = randi_range(1,5)
			rng.randomize
			var spawnx = rng.randf_range(-200,200)
			var spawny = rng.randf_range(-200,200)
			var enemyPos = Vector2(spawnx,spawny)
			if enemyPos.distance_to($Player1.global_position) >= 50:
				if (enemy == 1 && wavepower >= 1):
					var summon = preload("res://Scenes/goblin.tscn").instantiate()
					add_child(summon)
					summon.enemyDead.connect(enemyDefeated)
					summon.global_position = enemyPos
					wavepower = wavepower - 1
					remaining += 1
					summon.activated = true
				elif (enemy == 2 && wavepower >= 2):
					var summon = preload("res://Scenes/Thief.tscn").instantiate()
					add_child(summon)
					summon.enemyDead.connect(enemyDefeated)
					summon.global_position = enemyPos
					wavepower = wavepower - 2
					remaining += 1
					summon.activated = true
				elif (enemy == 3 && wavepower >= 3):
					var summon = preload("res://Scenes/sorcerer.tscn").instantiate()
					add_child(summon)
					summon.enemyDead.connect(enemyDefeated)
					summon.global_position = enemyPos
					wavepower = wavepower - 3
					remaining += 1
				elif (enemy == 4 && wavepower >= 8):
					var summon = preload("res://Scenes/golden_knight.tscn").instantiate()
					add_child(summon)
					summon.enemyDead.connect(enemyDefeated)
					summon.global_position = enemyPos
					wavepower = wavepower - 8
					remaining += 1
					summon.activate()
				elif (enemy == 5 && wavepower >= 6):
					var summon = preload("res://Scenes/goblin_masked.tscn").instantiate()
					add_child(summon)
					summon.enemyDead.connect(enemyDefeated)
					summon.global_position = enemyPos
					wavepower = wavepower - 6
					remaining += 1
					summon.activated = true
	$Player1/Camera2D/CanvasLayer/WaveCounter.text = "Wave: " + str(wave)
	$Player1/Camera2D/CanvasLayer/EnemyCounter.text = "Remaining: " + str(remaining)
func completed():
	$Player1/Camera2D/CanvasLayer/EnemyCounter.visible = false
	$Player1/Camera2D/CanvasLayer/WaveCounter.visible = false
	$Door.queue_free()

func next_level():
	if !Global.boss_rush:
		Global.coins = Global.coins + 20
	else:
		Global.coins = Global.coins + 5
	$Player1/TransitionPlayer.play("Fade_out")
	$Timer.start()

func _on_timer_timeout():
	if !Global.boss_rush:
		Global.health = $Player1.health
		Global.change_next_level()
		get_tree().change_scene_to_file(Global.next_level)
	else:
		Global.change_next_level()
		get_tree().change_scene_to_file(Global.next_level)

func camera_zoom():
	$Player1/Camera2D.zoom.x = .5
	$Player1/Camera2D.zoom.y = .5

func _on_area_2d_area_entered(area):
	if !started:
		camera_zoom()
		$Player1/Camera2D/CanvasLayer/WaveCounter.visible = true
		$Player1/Camera2D/CanvasLayer/EnemyCounter.visible = true
		wave_completed()
		started = true

func enemyDefeated():
	remaining -= 1
	$Player1/Camera2D/CanvasLayer/EnemyCounter.text = "Remaining: " + str(remaining)
	if remaining == 0:
		$Timer2.start()

func _on_timer_2_timeout():
	wave_completed()
