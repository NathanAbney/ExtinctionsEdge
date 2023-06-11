extends Node2D

func _on_area_2d_area_entered(area):
	MusicController.play_sound(15)
	get_parent().get_parent().get_child(2).freeze()
	Global.frozen = true
	queue_free()
