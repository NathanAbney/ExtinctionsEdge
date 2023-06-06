extends Node

var music = load("res://Audio/Songs/Exploration.ogg") # Track 1 = Exploration music
var boss = load("res://Audio/Songs/Boss3.ogg") # Track 2 = Boss Fight music

func play_music(song : int):
	if (song == 1):
		$Music.stream = music
	elif (song == 2):
		$Music.stream = boss
	$Music.bus = "Music"
	$Music.play()

var coin = load("res://Audio/Sounds/coin.wav") # Sound 1 = Coin
var shoot = load("res://Audio/Sounds/shoot.wav") # Sound 2 = Shoot
var regain = load("res://Audio/Sounds/regain.wav") # Sound 3 = Regain
var bubble = load("res://Audio/Sounds/bubble.wav") # Sound 4 = Bubble
var heal = load("res://Audio/Sounds/heal.wav") # Sound 5 = Heal
var speed = load("res://Audio/Sounds/speed.wav") # Sound 6 = Speed
var open = load("res://Audio/Sounds/open.mp3") # Sound 7 = Open
var step = load("res://Audio/Sounds/step.wav") # Sound 8 = Step

func play_sound(sound : int):
	var stream = AudioStreamPlayer.new()
	if (sound == 1):
		stream.stream = coin
	elif (sound == 2):
		stream.stream = shoot
	elif (sound == 3):
		stream.stream = regain
	elif (sound == 4):
		stream.stream = bubble
	elif (sound == 5):
		stream.stream = heal
	elif (sound == 6):
		stream.stream = speed
	elif (sound == 7):
		stream.stream = open
	elif (sound == 8):
		stream.stream = step
	stream.bus = "Sound"
	add_child(stream)
	stream.play()
