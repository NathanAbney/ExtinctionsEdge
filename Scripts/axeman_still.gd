extends CharacterBody2D

var speed = 1
var target: Vector2 = Vector2.ZERO
var player = null
var health = 8
var hurt = false
var activated = false
var invincible = false
signal enemyDead

func _ready():
	if Global.enemy_hats:
		$Hat.visible = true
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	var target = player.global_position

func _physics_process(delta):
	if activated and !Global.frozen and health > 0:
		$axe.rotate(0.04)
		$axe2.rotate(0.04)
		if(is_instance_valid(self) && is_instance_valid(player)):
			if player.global_position.x > global_position.x:
				$Sprite2D.flip_h = false
			else:
				$Sprite2D.flip_h = true
	elif Global.frozen:
		if !$AnimationPlayer.frozen():
			$AnimationPlayer.freeze()

func _on_area_2d_area_entered(area):
	pass

func _on_hurt_timeout():
	hurt = false

func _on_activation_area_area_entered(area):
	activated = true

func active():
	activated = true

func die():
	emit_signal("enemyDead")
	$axe.queue_free()
	$axe2.queue_free()
	$Hat.queue_free()
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
