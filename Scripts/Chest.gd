extends Node2D

var opened = false
var rng = RandomNumberGenerator.new()

func _on_area_2d_area_entered(area):
	if !opened:
		$Sprite2D.frame = 597
		open()

func open():
	for i in range(3):
		rng.randomize()
		var loot = randi_range(0,5)
		var item
		if loot == 0 or loot == 1 or loot == 2 or loot == 3:
			item = preload("res://Scenes/coin.tscn").instantiate()
		if loot == 4:
			item = preload("res://Scenes/potion.tscn").instantiate()
		if loot == 5:
			item = preload("res://Scenes/potion2.tscn").instantiate()
		get_parent().add_child(item)
		item.position.x = global_position.x + rng.randi_range(-15,15)
		if item.position.x < 0:
			clamp(-15,-10,item.position.x)
		if item.position.x > 0:
			clamp(10,15,item.position.x)
		item.position.x = global_position.x + rng.randi_range(-15,15)
		if item.position.y < 0:
			clamp(-15,-10,item.position.y)
		if item.position.y > 0:
			clamp(10,15,item.position.y)
	opened = true