extends CharacterBody2D

var speed = 500
var target: Vector2 = Vector2.ZERO
var player = null
var health = 100
var hurt = false
var rng = RandomNumberGenerator.new()
var moveReady = true
var active = false;
var dash_active = false

func _ready():
	if Global.enemy_hats:
		$Hat.visible = true
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	if dash_active:
		velocity = global_position.direction_to(target) * speed
		if global_position.distance_to(target) <= 10:
			$AnimationPlayer.play("Idle")
			$Attack.start()
			dash_active = false
			$Duplicate.stop()
		move_and_slide()
	if moveReady and active:
		if(player.global_position.x < global_position.x):
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		var move = rng.randi_range(0,1)
		rng.randomize
		attack(move)

func attack(move : int):
	if move == 0:
		$AnimationPlayer.play("Walking")
		$Duplicate.start()
		dash_active = true
		target = player.global_position
	if move == 1:
		for i in range(3):
			var summon = preload("res://Scenes/mushroom_medium.tscn").instantiate()
			get_parent().add_child(summon)
			summon.position.x = global_position.x + rng.randf_range(5,100)
			summon.position.y = global_position.y + rng.randf_range(5,100)  
			rng.randomize
			summon.activated = true
	moveReady = false
	$Attack.start()

func _on_area_2d_area_entered(area):
	health = health - 1
	$Life.update(health)
	if health == 0:
		queue_free()
		get_parent().get_parent().next_level()

func _on_attack_timeout():
	moveReady = true

func _on_activation_box_area_entered(area):
	get_parent().get_parent().camera_zoom()
	active = true
	moveReady = false
	$Attack.start(3)

func _on_duplicate_timeout():
	var summon = preload("res://Scenes/boss2Dud.tscn").instantiate()
	get_parent().add_child(summon)
	summon.position = global_position
	summon.flip_h = $Sprite2D.flip_h
	summon.frame = $Sprite2D.frame
	summon.z_index = -1
