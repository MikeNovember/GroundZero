extends AudioStreamPlayer

func _ready():
	var res = load("res://mario_08.wav")
	print("load")
	set_stream(res)
	set_volume_db(24)
	playing = true
	play()
	
	
	pass
