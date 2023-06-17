extends AnimationPlayer

var frozen : bool = false
var animName

func freeze():
	animName = current_animation
	frozen = true
	pause()
	$Timer.start()

func _on_timer_timeout():
	frozen = false
	play(animName,-1,1.0,false)
