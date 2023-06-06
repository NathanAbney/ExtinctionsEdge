extends CharacterBody2D

var speed = 300
var target: Vector2 = Vector2.ZERO
var player = null
var health = 100
var hurt = false
var moveReady = false
var active = false;
var throw = 10
var dash_active = false;

func _ready():
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	$AnimationPlayer.play("Idle");

func _physics_process(delta):
	if dash_active:
		velocity = global_position.direction_to(target) * speed
		if global_position.distance_to(target) <= 20:
			$AnimationPlayer.play("Idle")
			$Attack.start()
			dash_active = false
			$AnimationPlayer.play("Idle");
		move_and_slide()
	if moveReady and active:
		attack()

func attack():
	dash_active = true
	target = player.global_position
	moveReady = false
	$AnimationPlayer.play("Walking");
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
		h = 30
	else:
		h = -30
	if(player.global_position.y > global_position.y):
		y = 30
	else:
		y = -30
	var rock = preload("res://Scenes/rockthrow.tscn").instantiate()
	get_parent().get_parent().add_child(rock)
	rock.set_collision_mask_value(2, true)
	rock.position.x = global_position.x + h
	rock.position.y = global_position.y + y
	rock.velocity = global_position.direction_to(player.global_position) * 230

func _on_attack_2_timeout():
	moveReady = true;
