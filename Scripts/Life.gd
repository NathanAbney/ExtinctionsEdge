extends Container

func update(health : int):
	Global.health = health
	if health == 6:
		$Heart3.frame = 530
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 5:
		$Heart3.frame = 531
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 4:
		$Heart3.frame = 532
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 3:
		$Heart3.frame = 532
		$Heart2.frame = 531
		$Heart1.frame = 530
	if health == 2:
		$Heart3.frame = 532
		$Heart2.frame = 532
		$Heart1.frame = 530
	if health == 1:
		$Heart3.frame = 532
		$Heart2.frame = 532
		$Heart1.frame = 531
	if health == 0:
		$Heart3.frame = 532
		$Heart2.frame = 532
		$Heart1.frame = 532
