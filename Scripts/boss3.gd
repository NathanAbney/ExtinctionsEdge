extends CharacterBody2D

var speed = 500
var target: Vector2 = Vector2.ZERO
var player = null
var health = 60
var hurt = false
var rng = RandomNumberGenerator.new()
var moveReady = true
var active = false;
var throw = 10

func _ready():
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	if moveReady and active:
		attack()

func attack():
	rng.randomize()
	var move = rng.randi_range(0,1)
	if move == 1:
		print("Scaling")
		if get_parent().get_child_count() > 0:
			var scaled = false
			var random_child = get_parent().get_child(randi() % get_parent().get_child_count())
			if random_child != self:
				random_child.invinc()
				scaled = true
			if !scaled:
				move = 0
	if move == 0:
		for i in range(6):
			var summon = preload("res://Scenes/goblin.tscn").instantiate()
			get_parent().add_child(summon)
			summon.position.x = global_position.x + rng.randf_range(-100,100)
			summon.position.y = global_position.y + rng.randf_range(-100,100)  
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
	print("move ready")

func _on_activation_box_area_entered(area):
	get_parent().get_parent().camera_zoom()
	for i in range(get_parent().get_child_count()):
		var random_child = get_parent().get_child(randi() % get_parent().get_child_count())
		if random_child != self:
			random_child.active()
	active = true
	$Attack.start()
	$Throw.start()

func _on_throw_timeout():
	var h
	var y
	if(player.global_position.x > global_position.x):
		h = 10
	else:
		h = -10
	if(player.global_position.y > global_position.y):
		y = 10
	else:
		y = -10
	var potion = preload("res://Scenes/potionattack.tscn").instantiate()
	get_parent().get_parent().add_child(potion)
	potion.set_collision_mask_value(2, true)
	potion.position.x = global_position.x + h
	potion.position.y = global_position.y + y
	potion.velocity = global_position.direction_to(player.global_position) * 400
