extends Node

var health : int
var dino : Texture2D
var coins : int
var hat : int = 0
var god_mode : bool = false
var current_level : int = 0
var next_level : String
var boss_rush : bool = false
var no_hit : bool = false
var game_beat : bool = false
var boss_rush_beaten : bool = false
var cheat_song : bool = false
var frozen : bool = false
var enemy_hats : bool = false
var dark_mode : bool = false
var boss : int
var QRActive : bool = false
var supersmall : bool = false

# Setting up the room data

var sr1 = "res://Rooms/Small/SmallRoom2.tscn"
var sr2 = "res://Rooms/Small/SmallRoom3.tscn"
var sr3 = "res://Rooms/Small/SmallRoom4.tscn"
var sr4 = "res://Rooms/Small/SmallRoom5.tscn"
var sr5 = "res://Rooms/Small/SmallRoom6.tscn"
var sr6 = "res://Rooms/Small/GoldRoom.tscn"
var sr7 = "res://Rooms/Small/TrapRoom.tscn"
var sr8 = "res://Rooms/Small/SmallRoom7.tscn"
var sr9 = "res://Rooms/Small/SmallRoom8.tscn"

var small_rooms = [sr1, sr2, sr3, sr4, sr5, sr6, sr7, sr8, sr9]

var mr1 = "res://Rooms/Medium/MediumRoom1.tscn"
var mr2 = "res://Rooms/Medium/MediumRoom2.tscn"
var mr3 = "res://Rooms/Medium/MediumRoom3.tscn"
var mr4 = "res://Rooms/Medium/MediumRoom4.tscn"
var mr5 = "res://Rooms/Medium/MediumRoom5.tscn"
var mr6 = "res://Rooms/Medium/MediumRoom6.tscn"

var med_rooms = [mr1, mr2, mr3, mr4, mr5, mr6]

var lr1 = "res://Rooms/Large/LargeRoom1.tscn"
var lr2 = "res://Rooms/Large/LargeRoom2.tscn"
var lr3 = "res://Rooms/Large/LargeRoom3.tscn"
var lr4 = "res://Rooms/Large/LargeRoom4.tscn"

var large_rooms = [lr1, lr2, lr3, lr4]

func change_next_level():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if !boss_rush:
		if (current_level == 1 or current_level == 3): # Small rooms
			var room = rng.randi_range(0,small_rooms.size() - 1)
			next_level = small_rooms[room]
		if (current_level == 2 or current_level == 4): # Medium rooms
			var room = rng.randi_range(0,med_rooms.size() - 1)
			next_level = med_rooms[room]
		if current_level == 5: # Large rooms
			var room = rng.randi_range(0,large_rooms.size() - 1)
			next_level = large_rooms[room]
		if current_level == 6: # Wave battle
			next_level = "res://Rooms/Boss/Wave.tscn"
		if current_level == 7: # Boss rooms
			var room = rng.randi_range(1,3)
			boss = room
			next_level = "res://Scenes/dialogue.tscn"
	else:
		if current_level == 1:
			MusicController.play_music(2)
			next_level = "res://Rooms/Boss/Boss2.tscn"
		elif current_level == 2:
			MusicController.play_music(13)
			next_level = "res://Rooms/Boss/Boss1.tscn"
		elif current_level == 3:
			boss_rush_beaten = true
			next_level = "res://Scenes/Victory.tscn"
	frozen = false
