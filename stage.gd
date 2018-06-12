extends Node

export (PackedScene) var Enemy
export (PackedScene) var Coin
export (int) var enemyCount
export (int) var coinCount

func _ready():
	randomize()
	$player.connect("shoot",$HUD,"_on_shoot"); 
	$WorldCompleted.connect("finish_area_reached",$HUD,"_on_finish_area_reached")
	$WorldCompleted.connect("finish_area_reached",$player,"_on_finish_area_reached")
	$player.connect("lose",$HUD,"_on_lose");
	for i in range(coinCount):
		var coin = Coin.instance()
		$coins.add_child(coin)
	
	for i in range(enemyCount):
		var enemy = Enemy.instance()
		enemy.connect("enemy_killed",$HUD,"_on_enemy_killed")
		$enemies.add_child(enemy)
	
	for coin in $coins.get_children():
		coin.connect("coin_picked", $player, "on_coin_picked")
		coin.connect("coin_picked",$HUD,"_on_coin_picked")
