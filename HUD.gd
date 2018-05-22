extends CanvasLayer

func _on_win():
	print('received win signal')
	$YouWon.visible = true