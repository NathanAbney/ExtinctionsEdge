extends Node

var time : float = 0.0;

func start_clock():
	time = 0.0
	$Timer.start()

func stop_clock():
	$Timer.stop()

func _on_timer_timeout():
	time = time + 0.1
