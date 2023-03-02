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

func _physics_process(delta):
	if !hurt and activated:
		check_route()
		target = player.global_position
		velocity = global_position.direction_to(target) * speed
		if player.global_position.x > global_position.x:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
		move_and_slide()

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

func _on_activation_area_area_entered(area):
	activated = true

func die():
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	$Life.queue_free()
	$Sprite2D.visible = false
	$Shadow.visible = false
	$Particles.emitting = true
	$DeathTimer.start()

func _on_death_timer_timeout():
	queue_free()
