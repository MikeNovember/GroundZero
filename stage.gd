extends Node

func _ready():
	for coin in $coins.get_children():
		coin.connect("coin_picked", $player, "on_coin_picked")
