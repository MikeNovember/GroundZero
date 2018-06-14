extends NinePatchRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var menu = false
var open = false

var currentLabel = 0
var labels 

var pointer


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_unhandled_key_input(true)
	labels = get_node("Labels").get_children()
	pointer = get_node("Sprite")
	pointer_update()
	
	
func pointer_update():
	pointer.set_global_position(Vector2(pointer.get_global_position().x,labels[currentLabel].get_global_position().y + 10))
	
#
#func _fixed_process(delta):
#	if open: 
#
#		if menu:
#			set("visible",true)
#			#get_tree().paused = false
#			open = false


func _unhandled_input(event):
	#print(event)
	if Input.is_key_pressed(KEY_P):
		if open :
			_on_resume()
		else:
			open = true
			set("visible",true)
			get_tree().paused = true;	
	if open:
		if Input.is_key_pressed(KEY_DOWN):
			print("TU")
			if currentLabel == labels.size() - 1:
				currentLabel = 0
				pointer_update()
			else:
				currentLabel += 1
				pointer_update()
		if Input.is_key_pressed(KEY_UP):
			if currentLabel == 0:
				currentLabel = labels.size() - 1
				pointer_update()
			else:
				currentLabel -= 1
				pointer_update()
		if Input.is_key_pressed(KEY_ENTER):
			if labels[currentLabel].get_name() == "Resume":
				_on_resume()
			elif labels[currentLabel].get_name() == "Restart":
				_on_restart()
			else:
				_on_exit()
		
				
			
		

func _on_resume():
	open = false
	set("visible",false)
	get_tree().paused = false;

func _on_exit():
	get_tree().quit()
	
func _on_restart():
	print("Restart")
	get_tree().change_scene("res://stage.tscn")
	self._on_resume()
	
	
		
	#if open:
	#	if event.is_action_pressed("ui_menu"):
	#		menu = true
	#	elif event.is_action_released("ui_menu"):
	#		menu = false
			


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


