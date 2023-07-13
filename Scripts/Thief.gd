extends CharacterBody2D

var speed = 1
var target: Vector2 = Vector2.ZERO
var player = null
var health = 2
var hurt = false
var activated = false
var invincible = false
signal enemyDead

func _ready():
	if Global.enemy_hats:
		$Hat.visible = true
	$Sprite2D.modulate.a = 0
	$Hat.modulate.a = 0
	$Shadow.modulate.a = 0
	$Life/Heart1.modulate.a = 0
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	var target = player.global_position

func _physics_process(delta):
	if !hurt and activated and !Global.frozen:
		if(is_instance_valid(self) && is_instance_valid(player)):
			velocity = global_position.direction_to(player.global_position) * speed
			if player.global_position.x > global_position.x:
				$Sprite2D.flip_h = false
			else:
				$Sprite2D.flip_h = true
			change_opacity()
			move_and_collide(velocity)
	elif Global.frozen:
		if !$AnimationPlayer.frozen:
			$AnimationPlayer.freeze()

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


func _on_steal_area_body_entered(body):
	print("Stolen")
	Global.coins = Global.coins - 1

func change_opacity():
	var distance = (global_position - player.global_position).length()
	var visibilityDistance = 200.0  # Adjust this value to control the visibility distance
	var opacity = 1.0 - (distance / visibilityDistance)
	opacity = clamp(opacity, 0, 1)
	$Sprite2D.modulate.a = opacity
	$Hat.modulate.a = opacity
	$Shadow.modulate.a = opacity
	$Life/Heart1.modulate.a = opacity
