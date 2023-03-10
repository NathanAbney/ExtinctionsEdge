extends VBoxContainer

func _on_last_pressed():
	Global.hat = Global.hat - 1
	if Global.hat < 0:
		Global.hat = 4
	$Container/Sprite2D.frame = Global.hat

func _on_next_pressed():
	Global.hat = Global.hat + 1
	if Global.hat > 4:
		Global.hat = 0
	$Container/Sprite2D.frame = Global.hat
