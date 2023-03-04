extends CharacterBody2D

var speed = 40
var target: Vector2 = Vector2.ZERO
var player = null
var health = 40
var phase = 1
var hurt = false
var rng = RandomNumberGenerator.new()
var moveReady = true
var mana = 10;
var active = false;

func _ready():
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	if !hurt and moveReady and active:
		var move = rng.randi_range(0,1)
		rng.randomize
		attack(move)

func attack(move : int):
	if move == 0:
		if(player.global_position.x < global_position.x):
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		for i in range(5):
			var summon = preload("res://Scenes/gremlin.tscn").instantiate()
			get_parent().add_child(summon)
			summon.position.x = global_position.x + rng.randf_range(5,80)
			summon.position.y = global_position.y + rng.randf_range(5,80)  
			rng.randomize
			summon.activated = true
		$Attack.start()
	if move == 1:
		for i in range(6):
			$FlameTimer.start()
	moveReady = false

func _on_area_2d_area_entered(area):
	$Hurt.start()
	hurt = true
	health = health - 1
	$Life.update(health)
	if health == 0:
		queue_free()
		get_parent().get_parent().next_level()
	if health == 20:
		global_position.x = global_position.x + rng.randf_range(5,90)
		global_position.y = global_position.y + rng.randf_range(5,90)
		phase = 2

func _on_hurt_timeout():
	hurt = false

func _on_attack_timeout():
	moveReady = true
	mana = 10

func _on_flame_timer_timeout():
	var FlameLash = preload("res://Scenes/FlameLash.tscn").instantiate()
	get_parent().add_child(FlameLash)
	FlameLash.position = global_position
	FlameLash.velocity = global_position.direction_to(player.global_position) * 250
	mana = mana - 1
	if mana != 0:
		$FlameTimer.start()
	if mana == 0:
		$Attack.start()

func _on_activation_box_area_entered(area):
	get_parent().get_parent().camera_zoom()
	active = true
