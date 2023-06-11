extends Node2D

var opened = false
var rng = RandomNumberGenerator.new()

func _on_area_2d_area_entered(area):
	if !opened:
		$Sprite2D.frame = 597
		open()

func open():
	MusicController.play_sound(7)
	for i in range(3):
		rng.randomize()
		var loot = randi_range(0,100)
		var item
		if loot < 85:
			item = preload("res://Scenes/coin.tscn").instantiate()
		if loot >= 85 && loot < 90:
			item = preload("res://Scenes/potion3.tscn").instantiate()
		if loot >= 90 && loot < 95:
			item = preload("res://Scenes/potion.tscn").instantiate()
		if loot >= 95 && loot < 101:
			item = preload("res://Scenes/potion2.tscn").instantiate()
		get_parent().add_child(item)
		var spawnX = rng.randi_range(-25, 25)
		var spawnY = rng.randi_range(-25, 25)
		var distance = Vector2(spawnX, spawnY).length()
		while distance < 10:
			spawnX = rng.randi_range(-25, 25)
			spawnY = rng.randi_range(-25, 25)
			distance = Vector2(spawnX, spawnY).length()
		item.position.x = global_position.x + spawnX
		item.position.y = global_position.y + spawnY
	opened = true
