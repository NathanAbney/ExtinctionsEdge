extends Node2D

func _ready():
	$CoinAmount.text = str(Global.coins)
