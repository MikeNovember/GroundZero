extends CanvasLayer

var coins = 5

func _on_win():
	print('received win signal')
	$YouWon.visible = true
	

func on_coin_picked():
	print("Picked here")
	coins = coins + 1
	$Score.text = str(coins)
	

func on_shoot():
	print("shoot")
	coins = coins - 1
	$Score.text = str(coins)
	