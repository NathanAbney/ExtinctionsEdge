extends Container

func update(health : int):
	if health == 4:
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 3:
		$Heart2.frame = 531
		$Heart1.frame = 530
	if health == 2:
		$Heart2.frame = 532
		$Heart1.frame = 530
	if health == 1:
		$Heart2.frame = 532
		$Heart1.frame = 531
	if health == 0:
		$Heart2.frame = 532
		$Heart1.frame = 532
