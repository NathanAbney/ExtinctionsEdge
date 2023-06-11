extends Container

func update(health : int):
	if health == 8:
		$Heart4.frame = 530
		$Heart3.frame = 530
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 7:
		$Heart4.frame = 531
		$Heart3.frame = 530
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 6:
		$Heart4.frame = 532
		$Heart3.frame = 530
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 5:
		$Heart4.frame = 532
		$Heart3.frame = 531
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 4:
		$Heart4.frame = 532
		$Heart3.frame = 532
		$Heart2.frame = 530
		$Heart1.frame = 530
	if health == 3:
		$Heart4.frame = 532
		$Heart3.frame = 532
		$Heart2.frame = 531
		$Heart1.frame = 530
	if health == 2:
		$Heart4.frame = 532
		$Heart3.frame = 532
		$Heart2.frame = 532
		$Heart1.frame = 530
	if health == 1:
		$Heart4.frame = 532
		$Heart3.frame = 532
		$Heart2.frame = 532
		$Heart1.frame = 531
	if health == 0:
		$Heart4.frame = 532
		$Heart3.frame = 532
		$Heart2.frame = 532
		$Heart1.frame = 532
