extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var currentLabel = 0
var labels 

var pointer

var controls


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_unhandled_key_input(true)
	labels = get_node("Labels").get_children()
	pointer = get_node("Cursor")
	pointer_update()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func pointer_update():
	pointer.set_global_position(Vector2(pointer.get_global_position().x,labels[currentLabel].get_global_position().y + 10))
	

func _unhandled_input(event):
		
		if controls == true and event is InputEventKey:
			_on_controls_disabled()
			return
	
		if Input.is_key_pressed(KEY_DOWN):
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
			var label = labels[currentLabel].get_name()
			if label == "Start":
				_on_start()
			elif label == "Controls":
				_on_controls()
			elif label == "BestScores":
				_on_best_scores()
			else:
				_on_exit()
				
		
			
			
		
				
		
func _on_start():
	get_tree().change_scene("res://stage.tscn")
	
func _on_controls():
	print("on controls")
	pass
	
func _on_best_scores():
	print("Best scores")
	pass
	
func _on_exit():
	get_tree().quit()
	