extends Container

func update(health : int):
	if health == 100:
		$HealthBar.frame = 0
	elif health % 5 == 0:
		$HealthBar.frame = $HealthBar.frame + 1
