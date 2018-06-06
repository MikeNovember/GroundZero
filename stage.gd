extends Node


func _ready():
	$player.connect("shoot",$HUD,"on_shoot"); 
	$WorldCompleted.connect("finish_area_reached",$HUD,"on_finish_area_reached")
	for enemy in $enemies.get_children():
		enemy.connect("enemy_killed",$HUD,"on_enemy_killed")
	#this.connect("point_inc",$HUD,"on_point_inc");
	#this.connect("point_dec",$HUD,"on_point_dec");
	for coin in $coins.get_children():
		coin.connect("coin_picked", $player, "on_coin_picked")
		coin.connect("coin_picked",$HUD,"on_coin_picked")
