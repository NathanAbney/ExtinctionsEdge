extends Node2D
var bought = false
var inArea = false
var price = 50

func ready():
	$"Coin Amount".text = "" + str(price)

func _physics_process(delta):
	if (Input.is_action_just_pressed("buy") and !bought and inArea):
		if (Global.coins < price):
			MusicController.play_sound(11)
		else:
			purchase()

func _on_area_2d_area_entered(area):
	if !bought:
		inArea = true
		$Sprite2D.visible = true
		$"Coin Amount".visible = true

func _on_area_2d_area_exited(area):
	inArea = false
	$Sprite2D.visible = false
	$"Coin Amount".visible = false

func purchase():
	bought = true
	$Sprite2D.visible = false
	$"Coin Amount".visible = false
	Global.coins = Global.coins - price
	get_parent().get_parent().get_child(2).sethealth(6)
	MusicController.play_sound(10)
