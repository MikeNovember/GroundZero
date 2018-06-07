extends Node


func _ready():
	$player.connect("shoot",$HUD,"_on_shoot"); 
	$WorldCompleted.connect("finish_area_reached",$HUD,"_on_finish_area_reached")
	$player.connect("lose",$HUD,"_on_lose");
	for enemy in $enemies.get_children():
		enemy.connect("enemy_killed",$HUD,"_on_enemy_killed")
	
	for coin in $coins.get_children():
		coin.connect("coin_picked", $player, "on_coin_picked")
		coin.connect("coin_picked",$HUD,"_on_coin_picked")
