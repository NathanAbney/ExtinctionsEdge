extends Path2D

func _physics_process(delta):
	$PathFollow2D.progress = $PathFollow2D.progress + 1
	$PathFollow2D2.progress = $PathFollow2D2.progress + 1
