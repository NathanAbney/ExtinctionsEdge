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
		if loot < 90:
			item = preload("res://Scenes/coin.tscn").instantiate()
		if loot >= 90 && loot < 95:
			item = preload("res://Scenes/potion.tscn").instantiate()
		if loot >= 95 && loot < 100:
			item = preload("res://Scenes/potion2.tscn").instantiate()
		get_parent().add_child(item)
		item.position.x = global_position.x + rng.randi_range(-25,25)
		if item.position.x < 0:
			clamp(-25,-20,item.position.x)
		if item.position.x > 0:
			clamp(20,25,item.position.x)
		item.position.y = global_position.y + rng.randi_range(-25,25)
		if item.position.y < 0:
			clamp(-25,-20,item.position.y)
		if item.position.y > 0:
			clamp(20,25,item.position.y)
	opened = true
