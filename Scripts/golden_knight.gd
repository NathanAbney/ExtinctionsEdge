extends CharacterBody2D

var speed = 5000
var target: Vector2 = Vector2.ZERO
var player = null
var health = 4
var dash_active = false
var direction: Vector2
var hurt = false
var activated = false
signal enemyDead

func _ready():
	if Global.enemy_hats:
		$Hat.visible = true
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	if dash_active and !Global.frozen:
		if(is_instance_valid(self) && is_instance_valid(player)):
			velocity = direction.normalized() * 400
			move_and_slide()
			if is_on_wall():
				if !hurt:
					hurt = true
					health = health - 1
					$Life.update(health)
				if health == 0:
					die()
				direction = Vector2.ZERO
				dash_active = false;
				$AnimationPlayer.play("Idle")
				$Attack.start()

func attack():
	hurt = false
	if(is_instance_valid(self) && is_instance_valid(player) && !Global.frozen):
		var x = global_position.direction_to(player.global_position).x
		var y = global_position.direction_to(player.global_position).y
		var slope = (x/y) / 100
		if x/y < 0:
			slope = -slope
		direction.x = x * slope * speed
		direction.y = y * slope * speed
		$AnimationPlayer.play("Walking")
		dash_active = true

func _on_activation_box_area_entered(area):
	activate()

func activate():
	if !activated && !dash_active:
		activated = true
		$Timer.start()

func _on_attack_timeout():
	if !dash_active:
		attack()

func die():
	emit_signal("enemyDead")
	$Hat.queue_free()
	$CollisionShape2D.queue_free()
	$Area2D.queue_free()
	$Life.queue_free()
	$Sprite2D.visible = false
	$Shadow.visible = false
	$Particles.emitting = true
	$DeathTimer.start()

func _on_death_timer_timeout():
	queue_free()

func _on_timer_timeout():
	attack()
