extends NinePatchRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var menu = false

var currentLabel = 0
var labels 

var shown = false
var pointer


func _ready():
	set_process_unhandled_key_input(true)
	labels = get_node("Labels").get_children()
	pointer = get_node("Sprite")
	pointer_update()
	
	
func pointer_update():
	pointer.set_global_position(Vector2(pointer.get_global_position().x,labels[currentLabel].get_global_position().y + 10))
	
func _unhandled_input(event):
	#print(event)
	if shown:
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
			if labels[currentLabel].get_name() == "Restart":
				_on_restart()
			else:
				_on_exit()
		

func _on_exit():
	get_tree().quit()
	
	
func _on_resume():
	shown = false
	set("visible",false)
	get_tree().paused = false;
	
func _on_restart():
	print("Restart")
	get_tree().change_scene("res://stage.tscn")
	self._on_resume()


func show():
	shown = true
	set("visible",true)
	
	