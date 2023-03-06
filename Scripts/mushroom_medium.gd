extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var speed = 1
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
		velocity = global_position.direction_to(player.global_position) * speed
		if player.global_position.x > global_position.x:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
		move_and_collide(velocity)

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
	for i in range(2):
		rng.randomize
		var summon = preload("res://Scenes/mushroom_tiny.tscn").instantiate()
		get_parent().add_child(summon)
		summon.position.x = global_position.x + rng.randf_range(5,50)
		summon.position.y = global_position.y + rng.randf_range(5,50)
		summon.activated = true

func _on_death_timer_timeout():
	queue_free()
