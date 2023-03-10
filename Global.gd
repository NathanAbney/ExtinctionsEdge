extends Node

var health : int
var dino : Texture2D
var coins : int
var hat : int = 0
var god_mode : bool = false
var current_level : int = 0
var next_level : String
var boss_rush : bool = false

func change_next_level():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if !boss_rush:
		if (current_level == 1 or current_level == 3): # Small rooms
			var room = rng.randi_range(1,3)
			if room == 1:
				next_level = "res://Rooms/Small/SmallRoom2.tscn"
			if room == 2:
				next_level = "res://Rooms/Small/SmallRoom3.tscn"
			if room == 3:
				next_level = "res://Rooms/Small/SmallRoom4.tscn"
		if (current_level == 2 or current_level == 4): # Medium rooms
			var room = rng.randi_range(1,2)
			if room == 1:
				next_level = "res://Rooms/Medium/MediumRoom1.tscn"
			if room == 2:
				next_level = "res://Rooms/Medium/MediumRoom2.tscn"
		if current_level == 5: # Large rooms
			next_level = "res://Rooms/Large/LargeRoom1.tscn"
		if current_level == 6: # Boss rooms
			var room = rng.randi_range(1,3)
			if room == 1:
				next_level = "res://Rooms/Boss/Boss1.tscn"
			if room == 2:
				next_level = "res://Rooms/Boss/Boss2.tscn"
			if room == 3:
				next_level = "res://Rooms/Boss/Boss3.tscn"
	else:
		if current_level == 1:
			next_level = "res://Rooms/Boss/Boss2.tscn"
		if current_level == 2:
			next_level = "res://Rooms/Boss/Boss3.tscn"
		if current_level == 3:
			next_level = "res://Scenes/main_menu.tscn"
