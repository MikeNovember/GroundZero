extends Label

#func _init(color):
#	add_color_override("font_color",color)


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#set_text("sae se kszo")
	#set_font("res://fonts/menu_font.tres")
	#var font = Font.new()
	#push_font(font)
	add_font_override("font",load("res://fonts/menu_font.tres"))
	add_color_override("font_color",Color(0,0,0,1))
	#add_color_override("font_color",Color(234,47,47))
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func set_font_default():
	add_color_override("font_color",Color(0,0,0,1))
	
	
func set_font_last():
	add_color_override("font_color",Color(234,47,47))