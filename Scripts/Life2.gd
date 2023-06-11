extends Container

func update(health : int):
	if health == 2:
		$Heart1.frame = 530
	if health == 1:
		$Heart1.frame = 531
	if health == 0:
		$Heart1.frame = 532
		queue_free()
