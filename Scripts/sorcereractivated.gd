extends CharacterBody2D

var speed = 40
var target: Vector2 = Vector2.ZERO
var player = null
var health = 2
var hurt = false
var activated = false

func _ready():
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	var target = player.global_position
	$Timer.start()

func _physics_process(delta):
	if player.global_position.x > global_position.x:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

func check_route():
	if global_position.distance_to(target) <= 500:
		target = player.global_position

func _on_area_2d_area_entered(area):
	$Hurt.start()
	hurt = true
	health = health - 1
	$Life.update(health)
	if health == 0:
		die()

func _on_hurt_timeout():
	hurt = false

func _on_timer_timeout():
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
	if activated:
		$Sound.play()
		var fire = preload("res://Scenes/fire.tscn").instantiate()
		get_parent().add_child(fire)
		fire.set_collision_mask_value(2, true)
		fire.position.x = global_position.x + h
		fire.position.y = global_position.y + y
		fire.velocity = global_position.direction_to(player.global_position) * 250

func die():
	Global.coins = Global.coins + 1
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	$Life.queue_free()
	$Timer.queue_free()
	$Sprite2D.visible = false
	$Particles.emitting = true
	$Shadow.visible = false
	$DeathTimer.start()

func _on_death_timer_timeout():
	queue_free

func _on_area_2d_2_area_entered(area):
	activated = true
