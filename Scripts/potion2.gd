extends Node2D

func _on_area_2d_area_entered(area):
	get_parent().get_parent().get_child(2).speedboost()
	MusicController.play_sound(6)
	queue_free()
