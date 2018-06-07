extends CanvasLayer

var coins = 5
var enemies_killed = 0

func _on_win():
	print('received win signal')
	#$YouWon.visible = true

func _on_lose():
		$GameOver.visible = true

func _on_coin_picked():
	print("Picked here")
	coins = coins + 1
	$Score.text = str(coins)
	

func _on_shoot():
	print("shoot")
	coins = coins - 1
	$Score.text = str(coins)
	
func _on_finish_area_reached():
	$YouWon.visible = true
	var finalScoreLabel = $YouWon.get_child(0)
	finalScoreLabel.visible = true
	finalScoreLabel.text = str(_calc_score(enemies_killed,coins))

func _on_enemy_killed():
	enemies_killed = enemies_killed + 1
	
func _calc_score(enemies_killed, ammo_left):
	var ammo_factor = 100
	var enemies_killed_factor = 300
	return enemies_killed * enemies_killed_factor + ammo_factor * ammo_left 
	
