extends CharacterBody2D

var speed = 60
var target: Vector2 = Vector2.ZERO
var player = null

func _ready():
	if Global.enemy_hats:
		$Hat.visible = true
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	var target = player.global_position

func _physics_process(delta):
	if !Global.frozen:
		target = player.global_position
		velocity = global_position.direction_to(target) * speed
		if velocity.x < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		move_and_slide()
