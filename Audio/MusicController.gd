extends Node

var able = true

var music = load("res://Audio/Songs/Exploration.ogg") # Track 1 = Exploration
var boss = load("res://Audio/Songs/Boss3.ogg") # Track 2 = Mushroom Battle
var death = load("res://Audio/Songs/Death.ogg") # Track 3 = Game Over
var wave = load("res://Audio/Songs/Wave.ogg") # Track 4 = Wave
var song1 = load("res://Audio/Songs/Song1.ogg") # Track 5 = Edge Of Extinction
var intro = load("res://Audio/Songs/Intro.ogg") # Track 6 = Costellae Intro
var tut = load("res://Audio/Songs/tutorial.ogg") # Track 7 = Tutorial
var menu = load("res://Audio/Songs/menu.ogg") # Track 8 = Menu
var song2 = load("res://Audio/Songs/Song2.ogg") # Track 9 = Dinosaur Soup
var song3 = load("res://Audio/Songs/Song3.ogg") # Track 10 = Curse
var victory = load("res://Audio/Songs/Victory.ogg") # Track 11 = Victory Song
var alchemist = load("res://Audio/Songs/Alchemist.ogg") # Track 12 = Alchemist Battle
var wizard = load("res://Audio/Songs/Wizard.ogg") # Track 13 = Wizard Battle

var songs = [music, boss, death, wave, song1, intro, tut, menu, song2, song3, victory, alchemist, wizard]

var coin = load("res://Audio/Sounds/coin.wav") # Sound 1 = Coin
var shoot = load("res://Audio/Sounds/shoot.wav") # Sound 2 = Shoot
var regain = load("res://Audio/Sounds/regain.wav") # Sound 3 = Regain
var bubble = load("res://Audio/Sounds/bubble.wav") # Sound 4 = Bubble
var heal = load("res://Audio/Sounds/heal.wav") # Sound 5 = Heal
var speed = load("res://Audio/Sounds/speed.wav") # Sound 6 = Speed
var open = load("res://Audio/Sounds/open.mp3") # Sound 7 = Open
var step = load("res://Audio/Sounds/step.wav") # Sound 8 = Step
var hurt = load("res://Audio/Sounds/hurt.wav") # Sound 9 = Hurt
var buy = load("res://Audio/Sounds/purchase.wav") # Sound 10 = Buy
var deny = load("res://Audio/Sounds/deny.wav") # Sound 11 = deny
var select = load("res://Audio/Sounds/Retro4.ogg") # Sound 12 = select
var back = load("res://Audio/Sounds/Retro11.ogg") # Sound 13 = back
var valid = load("res://Audio/Sounds/Retro8.ogg") # Sound 14 = valid
var slow = load("res://Audio/Sounds/slow.wav") # Sound 15 = slow
var normalspeed = load("res://Audio/Sounds/normalspeed.wav") # Sound 16 = normal speed
var dooropen = load("res://Audio/Sounds/door open.wav") # Sound 17 = door open
var impact = load("res://Audio/Sounds/impact.wav") # Sound 18 = impact

var sounds = [coin, shoot, regain, bubble, heal, speed, open, step, hurt, buy, deny, select, back, valid, slow, normalspeed, dooropen, impact]

func play_music(song : int):
	if !Global.cheat_song:
		$Music.stream = songs[song - 1]
		$Music.bus = "Music"
		$Music.play()
	if song == 5 || song == 9 || song == 10:
		$Music.stream = songs[song - 1]
		$Music.bus = "Music"
		$Music.play()

func stop_music():
	$Music.stop()

func play_sound(sound : int):
	if able:
		var stream = AudioStreamPlayer.new()
		stream.stream = sounds[sound - 1]
		stream.bus = "Sound"
		add_child(stream)
		stream.play()
