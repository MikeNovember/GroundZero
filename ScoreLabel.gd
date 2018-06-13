extends Label


func _ready():
	add_font_override("font",load("res://fonts/menu_font.tres"))

func set_font_default():
	add_color_override("font_color",Color(0,0,0,1))
	
	
func set_font_last():
	add_color_override("font_color",Color(0,0,255))	