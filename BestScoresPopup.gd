extends PopupDialog


const BestScoresUtils = preload("res://BestScoresUtils.gd")
var open = false

func _ready():
	set_process_unhandled_key_input(true)
	

func _unhandled_input(event):
	if open and event is InputEventKey and event.is_pressed():
		self.hide()
		var EndMenu = get_parent().get_node("EndMenu")
		EndMenu.show()

func _on_BestScoresPopup_about_to_show():
	open = true
	var bestScores = parse_json(BestScoresUtils.get_scores())
	var lastScore = get_parent().last_player_score
	var bestScoresTab = get_node("BestScoresTab")
	
	for score in bestScores:
		if lastScore != null and lastScore["score"] == score["score"] and lastScore["player"] == score["player"]:
			bestScoresTab.add_child(_create_latest_entry(score["player"],score["score"]))
		else:
			bestScoresTab.add_child(_create_entry(score["player"],score["score"]))
			

func _create_entry(player,score):
	var ScoreLabel = preload("res://ScoreLabel.gd")
	var hbox = HBoxContainer.new()
	hbox.add_constant_override("separation",75)
	var player_name_label = ScoreLabel.new()
	player_name_label.set_custom_minimum_size(Vector2(150,0)) 
	player_name_label.set_text(player.to_upper())
	player_name_label.set_font_default()
	var score_label = ScoreLabel.new()
	score_label.set_custom_minimum_size(Vector2(150,0))
	score_label.set_text(str(score))
	score_label.set_font_default()
	
	hbox.add_child(player_name_label)
	hbox.add_child(score_label)
	
	return hbox
	
func _create_latest_entry(player,score):
	var ScoreLabel = preload("res://ScoreLabel.gd")
	var hbox = HBoxContainer.new()
	hbox.add_constant_override("separation",75)
	var player_name_label = ScoreLabel.new()
	player_name_label.set_custom_minimum_size(Vector2(150,0)) 
	player_name_label.set_text(player.to_upper())
	player_name_label.set_font_last()
	
	var score_label = ScoreLabel.new()
	score_label.set_custom_minimum_size(Vector2(150,0))
	score_label.set_text(str(score))
	score_label.set_font_last()
	
	hbox.add_child(player_name_label)
	hbox.add_child(score_label)
	
	return hbox