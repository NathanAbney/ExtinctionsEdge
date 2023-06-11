extends CharacterBody2D

var speed = 2.17
var target: Vector2 = Vector2.ZERO
var player = null
var health = 2
var hurt = false
var activated = false

func _ready():
	if Global.enemy_hats:
		$Hat.visible = true
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	var target = player.global_position

func _physics_process(delta):
	if !hurt and activated and !Global.frozen:
		velocity = global_position.direction_to(player.global_position) * speed
		if velocity.x < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		move_and_collide(velocity)

func _on_area_2d_area_entered(area):
	die()

func _on_activation_area_area_entered(area):
	activated = true

func die():
	$Hat.queue_free()
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	$Sprite2D.visible = false
	$Particles.emitting = true
	$Shadow.visible = false
	$DeathTimer.start()

func _on_death_timer_timeout():
	queue_free()
