extends Container

func update(health : int):
	if health == 60:
		$HealthBar.frame = 0
	elif health % 3 == 0:
		$HealthBar.frame = $HealthBar.frame + 1
