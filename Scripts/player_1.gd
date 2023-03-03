extends CharacterBody2D

@export var move_speed : float = 80
@export var health : int = 6
@export var hurt = false

signal dead

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	$TransitionPlayer.play("Fade_In")
	sethealth(Global.health)
	$Fade.visible = true
	if Global.dino != null:
		$Sprite2D.texture = Global.dino


func _physics_process(_delta):
	if (!hurt):
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
		velocity = input_direction * move_speed
		
		if hurt:
			velocity = Vector2.ZERO
		
		if velocity != Vector2.ZERO:
			state_machine.travel("walk")
			if velocity.x > 0:
				$Sprite2D.flip_h = false;
			if velocity.x < 0:
				$Sprite2D.flip_h = true;
		if velocity == Vector2.ZERO:
			state_machine.travel("idle")
		
		if (Input.is_action_just_pressed("Click")):
			shoot();
		
		move_and_slide()
	$Wand.look_at(get_global_mouse_position())

func take_damage():
	$Hurt.start()
	hurt = true
	state_machine.travel("damage")
	health = health - 1
	$Life.update(health)
	if health == 0:
		emit_signal("dead")

func _on_hurt_timeout():
	hurt = false

func shoot():
	var bullet = preload("res://Scenes/fire.tscn").instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Wand/Sprite2D/Marker2D.global_position
	bullet.velocity.x = (get_global_mouse_position().x - bullet.position.x) * 2
	bullet.velocity.y = (get_global_mouse_position().y- bullet.position.y) * 2
	bullet.z_index = -1

func _on_area_2d_area_entered(area):
	if !hurt:
		take_damage()

func sethealth(new : int):
	health = new
	$Life.update(health)

func speedboost():
	move_speed = 120
	$Speed.start()

func _on_speed_timeout():
	print("reset")
	move_speed = 80
