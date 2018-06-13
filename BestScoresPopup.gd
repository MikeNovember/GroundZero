extends PopupDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const BestScoresUtils = preload("res://BestScoresUtils.gd")
var open = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_unhandled_key_input(true)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _unhandled_input(event):
	if open and event is InputEventKey and event.is_pressed():
		self.hide()
		var EndMenu = get_parent().get_node("EndMenu")
		EndMenu.show()

func _on_BestScoresPopup_about_to_show():
	open = true
	var bestScores = parse_json(BestScoresUtils.get_scores())
	var lastScore = get_parent().get_last_score()
	var bestScoresTab = get_node("BestScoresTab")
	
	for score in bestScores:
		#var label_class = preload("res://ScoreLabel.gd")
		#var label = label_class.new()
		#var label
		#print(score["player"])
		#if lastScore["player"] == score["player"] and lastScore["score"] == score["score"]:
		#	print("LAST ONE!")
			#label = label_class.new(Color(234,47,47))
		#	label.set_font_last()
	#	else:
		#	label.set_font_default()
			#label = label_class.new(Color(0,0,0,1))
		#label.set_text(format.format({"player": score["player"],"score":score["score"]}))
		#"{0} : {1}".format([score["player"],score["score"]])
		var entry = _create_entry(score["player"],score["score"])
		bestScoresTab.add_child(entry)
	pass # replace with function body
#	open = true
#	var bestScores = parse_json(BestScoresUtils.get_scores())
#	var lastScore = get_parent().get_last_score()
#	var bestScoresTab = get_node("BestScoresTab")
#	print(lastScore)
#	var format = "{player} : {score}"
#	for score in bestScores:
#		var label_class = preload("res://ScoreLabel.gd")
#		var label = label_class.new()
#		#var label
#		#print(score["player"])
#		if lastScore["player"] == score["player"] and lastScore["score"] == score["score"]:
#			print("LAST ONE!")
#			#label = label_class.new(Color(234,47,47))
#			label.set_font_last()
#		else:
#			label.set_font_default()
#			#label = label_class.new(Color(0,0,0,1))
#		label.set_text(format.format({"player": score["player"],"score":score["score"]}))
#		#"{0} : {1}".format([score["player"],score["score"]])
#		bestScoresTab.add_child(label)
#	pass # replace with function body

func _create_entry(player,score):
	var ScoreLabel = preload("res://ScoreLabel.gd")
	var hbox = HBoxContainer.new()
	hbox.add_constant_override("separation",75)
	var player_name_label = ScoreLabel.new()
	player_name_label.set_custom_minimum_size(Vector2(150,0)) 
	player_name_label.set_text(player)
	
	var score_label = ScoreLabel.new()
	score_label.set_custom_minimum_size(Vector2(150,0))
	score_label.set_text(str(score))
	
	hbox.add_child(player_name_label)
	hbox.add_child(score_label)
	
	return hbox