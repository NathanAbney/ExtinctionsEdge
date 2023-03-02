extends CharacterBody2D

var speed = 150
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
	check_route()
	if !hurt and activated:
		velocity = global_position.direction_to(target) * speed
		if velocity.x < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		move_and_slide()

func check_route():
	if global_position.distance_to(target) <= 500:
		target = player.global_position

func _on_area_2d_area_entered(area):
	queue_free()

func _on_activation_area_area_entered(area):
	activated = true
