extends Node2D



func _on_area_2d_area_entered(area):
	Global.coins = Global.coins + 1
	queue_free()
