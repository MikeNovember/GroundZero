extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const BestScoresUtils = preload("res://BestScoresUtils.gd")
var currentLabel = 0
var labels 

var pointer

var controls
var best_scores

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_unhandled_key_input(true)
	labels = get_node("Labels").get_children()
	pointer = get_node("Cursor")
	pointer_update()

func pointer_update():
	pointer.set_global_position(Vector2(pointer.get_global_position().x,labels[currentLabel].get_global_position().y + 10))
	

func _unhandled_input(event):
#	BestScoresUtils.save_score("Kbaran",1)
#	print(BestScoresUtils.get_scores())
#	BestScoresUtils.save_score("Gosia",2)
#	print(BestScoresUtils.get_scores())
#	BestScoresUtils.save_score("tomasz",0)
#	print(BestScoresUtils.get_scores())
#	BestScoresUtils.save_score("Pszemo",2)
#	print(BestScoresUtils.get_scores())
	
	if controls and event is InputEventKey and event.is_pressed():
		return _on_controls_disabled();
	if best_scores and event is InputEventKey and event.is_pressed():
		return _on_best_scores_disbled()
				
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
#		elif label == "BestScores":
#			#_on_best_scores()
#			var someshit = "\n   dsada a  \n".replace("\n","").replace(" ","")
#			print(someshit)
#			pass
		else:
			_on_exit()	

func _on_start():
	get_tree().change_scene("res://stage.tscn")
	
func _on_controls():
	#print("on controls")
	controls = true
	get_node("Controls").set("visible",true)
	
func _on_controls_disabled():
	#print("On controls disabled")
	controls = false
	get_node("Controls").set("visible",false)
	#get_tree().paused = false
	
func _on_best_scores_disbled():
	#print("AAA")	
	best_scores = false
	get_node("BestScores").set("visible",false)
	
func _on_best_scores():
	best_scores = true
	get_node("BestScores").set("visible",true)
	var bestScoresTab = get_node("BestScores/ScoresLabels")
	var arr = parse_json(BestScoresUtils.get_scores())
	print(arr)
	var format = "{player} : {score}"
	for score in arr:
		var label_class = preload("res://ScoreLabel.gd")
		var label = label_class.new()
		print(score["player"])
		label.set_text(format.format({"player": score["player"],"score":score["score"]}))
		#"{0} : {1}".format([score["player"],score["score"]])
		bestScoresTab.add_child(label)
	
	
func _on_exit():
	get_tree().quit()
	