extends CharacterBody2D

@export var move_speed : float = 110
@export var health : int = 6
@export var hurt = false
@export var noshoot = false
@export var noshoot2 = false

signal dead

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	$Fade.visible = true
	$TransitionPlayer.play("Fade_In")
	sethealth(Global.health)
	if Global.dino != null:
		$Sprite2D.texture = Global.dino
	if Global.hat < 10:
		$Hat.visible = true
		$Hat.frame = Global.hat

func _physics_process(_delta):
	$Camera2D/CanvasLayer/CoinAmount.text = str(Global.coins)
	if (!hurt):
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
		velocity = input_direction * move_speed
		
		if hurt:
			velocity = Vector2.ZERO
		
		if velocity != Vector2.ZERO:
			if $Timer.time_left <= 0:
				$Timer/AudioStreamPlayer.pitch_scale = randf_range(0.4,1.6)
				$Timer/AudioStreamPlayer.play()
				$Timer.start(0.3)
			state_machine.travel("walk")
			if velocity.x > 0:
				$Sprite2D.flip_h = false;
				$Hat.flip_h = false;
				$Hat.position.x = -3.2
				$Hat.rotation = -.12
			if velocity.x < 0:
				$Sprite2D.flip_h = true;
				$Hat.flip_h = true
				$Hat.position.x = 3.2
				$Hat.rotation = .12
		if velocity == Vector2.ZERO:
			state_machine.travel("idle")
		
		if (Input.is_action_just_pressed("Click") and !noshoot):
			shoot();
		
		if (Input.is_action_just_pressed("Space") and !noshoot2):
			shoot2();
		
		if(Input.is_action_just_pressed("esc")):
			pause()
		
		move_and_slide()
	$Wand.look_at(get_global_mouse_position())

func take_damage():
	Global.no_hit = false
	$Hurt.start()
	hurt = true
	state_machine.travel("damage")
	health = health - 1
	$Life.update(health)
	if health == 0:
		MusicController.play_music(3)
		emit_signal("dead")
	else:
		MusicController.play_sound(9)

func _on_hurt_timeout():
	hurt = false

func shoot():
	var bullet = preload("res://Scenes/fire.tscn").instantiate()
	get_parent().add_child(bullet)
	MusicController.play_sound(2)
	bullet.position = $Wand/Sprite2D/Marker2D.global_position
	var x = global_position.direction_to(get_global_mouse_position()).x
	var y = global_position.direction_to(get_global_mouse_position()).y
	var slope = (x/y) / 100
	if x/y < 0:
		slope = -slope
	var direction = Vector2.ZERO
	direction.x = x * slope
	direction.y = y * slope
	bullet.velocity = direction.normalized() * 200
	bullet.z_index = -1

func shoot2():
	noshoot2 = true
	var bullet = preload("res://Scenes/earth_move.tscn").instantiate()
	get_parent().add_child(bullet)
	MusicController.play_sound(4)
	bullet.position = global_position
	$"Shoot Timer 2".start()

func _on_area_2d_area_entered(area):
	if !hurt && !Global.god_mode:
		take_damage()

func sethealth(new : int):
	health = new
	$Life.update(health)

func speedboost():
	move_speed = 140
	$Speed.start()

func _on_speed_timeout():
	move_speed = 110

func pause():
	noshoot = true
	$"Shoot Timer".start()
	var menu = preload("res://Scenes/pause_menu.tscn").instantiate()
	menu.scale.x = 1.25
	menu.scale.y = 1.25
	menu.position.x = global_position.x - 247
	menu.position.y = global_position.y - 161
	get_parent().add_child(menu)
	get_parent().get_tree().paused = true

func _on_shoot_timer_timeout():
	noshoot = false

func _on_shoot_timer_2_timeout():
	$Regain.emitting = true
	MusicController.play_sound(3)
	noshoot2 = false
