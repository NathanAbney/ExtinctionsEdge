extends Container

func update(health : int):
	if health == 40:
		$HealthBar.frame = 0
	elif health % 2 == 0:
		$HealthBar.frame = $HealthBar.frame + 1
