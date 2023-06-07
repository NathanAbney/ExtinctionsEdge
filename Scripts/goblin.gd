extends CharacterBody2D

var speed = 1.5
var target: Vector2 = Vector2.ZERO
var player = null
var health = 2
var hurt = false
var activated = false
var invincible = false
signal enemyDead

func _ready():
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	var target = player.global_position

func _physics_process(delta):
	if !hurt and activated:
		if(is_instance_valid(self) && is_instance_valid(player)):
			velocity = global_position.direction_to(player.global_position) * speed
			if player.global_position.x > global_position.x:
				$Sprite2D.flip_h = false
			else:
				$Sprite2D.flip_h = true
			move_and_collide(velocity)

func _on_area_2d_area_entered(area):
	if !invincible:
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

func active():
	activated = true

func die():
	emit_signal("enemyDead")
	Global.coins = Global.coins + 1
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	$Life.queue_free()
	$Sprite2D.visible = false
	$Shadow.visible = false
	$Particles.emitting = true
	$DeathTimer.start()

func _on_death_timer_timeout():
	queue_free()

func invinc():
	invincible = true
	$Invincible.start()
	$Sprite2D.modulate = Color("#ffbd00a8")
	set_scale(Vector2(3,3))
	speed = 1.7

func _on_invincible_timeout():
	set_scale(Vector2(1,1))
	invincible = false
	$Sprite2D.modulate = Color("#ffffff")
	speed = 1.5
