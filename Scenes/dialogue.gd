extends Node2D

var done = false
var closing = false

func _ready():
	MusicController.play_sound(18)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var d = rng.randi_range(1,4)
	if Global.boss == 1:
		if d == 1:
			$Camera2D/CanvasLayer/Start2.text = "Now that I think about it... I HAVE been craving some dinosaur soup..."
		if d == 2:
			$Camera2D/CanvasLayer/Start2.text = "Face it, brother, you'll never overcome my reign over the kingdom!"
		if d == 3:
			$Camera2D/CanvasLayer/Start2.text = "Prepare to face the arcane forces head on!"
		if d == 4:
			$Camera2D/CanvasLayer/Start2.text = "You're about to become a fozzilized memory!"
	elif Global.boss == 2:
		if d == 1:
			$Camera2D/CanvasLayer/Start2.text = "You'll never stand a chance against my fungal fury!"
		if d == 2:
			$Camera2D/CanvasLayer/Start2.text = "Man your stations! Our final battle has begun!"
		if d == 3:
			$Camera2D/CanvasLayer/Start2.text = "You're on my turf now, dino. You're about to get buried!"
		if d == 4:
			$Camera2D/CanvasLayer/Start2.text = "I may look like a fun-gi, but you're about to be a done guy!"
	elif Global.boss == 3:
		if d == 1:
			$Camera2D/CanvasLayer/Start2.text = "Hmm, I believe my potions are just about ready to crush this dinosaurs hopes and dreams!"
		if d == 2:
			$Camera2D/CanvasLayer/Start2.text = "You thought you were feasting? Prepare your tastebuds for the taste of defeat!"
		if d == 3:
			$Camera2D/CanvasLayer/Start2.text = "Today, I'm the chef. Our dish? Dinosaur soup!"
		if d == 4:
			$Camera2D/CanvasLayer/Start2.text = "And for our final experiment, I'll be turning a dinosaur into ashes."
	$Timer.start()
	$AnimationPlayer.play("Fade_in")

func _process(delta):
	if (Input.is_action_just_pressed("Click") and done):
		close()
	if (Input.is_action_just_pressed("Space") and done):
		close()

func close():
	if !closing:
		closing = true
		$AnimationPlayer.play("Fade_out")
		$Timer.start()

func _on_timer_timeout():
	if !done:
		print("Done")
		done = true
	else:
		if Global.boss == 1:
			MusicController.play_music(13)
			get_tree().change_scene_to_file("res://Rooms/Boss/Boss1.tscn")
		elif Global.boss == 2:
			MusicController.play_music(2)
			get_tree().change_scene_to_file("res://Rooms/Boss/Boss2.tscn")
		elif Global.boss == 3:
			MusicController.play_music(12)
			get_tree().change_scene_to_file("res://Rooms/Boss/Boss3.tscn")
