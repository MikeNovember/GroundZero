extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#set_text("sae se kszo")
	#set_font("res://fonts/menu_font.tres")
	#var font = Font.new()
	#push_font(font)
	add_font_override("font",load("res://fonts/main_menu.tres"))
	add_color_override("font_color",Color(0,0,0,1))
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
