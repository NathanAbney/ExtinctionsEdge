extends Node2D

var moving = false
var triggered = false
var platformOffset = Vector2.ZERO

func _process(delta):
	if get_parent().progress_ratio >= 1:
		moving = false
		done()
	if moving:
		get_parent().progress += (40 * delta)
		updatePosition()

func _on_area_2d_body_entered(body):
	if !triggered:
		var collisionShape = get_node("Left Wall/CollisionShape2D")
		collisionShape.set_deferred("disabled", false)
		moving = true
		triggered = true

func done():
	var collisionShape = get_node("Top Wall/CollisionShape2D")
	collisionShape.set_deferred("disabled", true)

func updatePosition():
	var player = get_parent().get_parent().get_parent().get_node("Player1") # Replace "Player" with the actual path to your player node
	player.position = get_global_transform().origin - platformOffset
