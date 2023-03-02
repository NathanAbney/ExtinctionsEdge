extends CharacterBody2D

var speed = 50
var target: Vector2 = Vector2.ZERO
var player = null

func _ready():
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	var target = player.global_position

func _physics_process(delta):
	target = player.global_position
	velocity = global_position.direction_to(target) * speed
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	move_and_slide()
