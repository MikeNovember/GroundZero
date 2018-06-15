extends CanvasLayer

const BestScoresUtils = preload("res://BestScoresUtils.gd")
#const EndMenu = preload("res://EndMenu.gd")

var coins = 5
var enemies_killed = 0

var start = OS.get_ticks_msec()

var last_score = 0

var last_player_score

func _on_win():
	print('received win signal')

func _on_lose():
		$kill_sound.play()
		$AnimationPlayer.play("death")
		$GameOver.visible = true
		get_tree().paused = true

func _on_coin_picked():
	get_node("coin_picked_sound").play(0)
	coins = coins + 1
	$Score.text = str(coins)
	
func _on_shoot():
	coins = coins - 1
	$Score.text = str(coins)
	
func _on_finish_area_reached():
	var duration = OS.get_ticks_msec() - start
	get_node("bomb_drop_sound").play()
	$YouWon.visible = true
	var finalScoreLabel = $YouWon.get_child(0)
	finalScoreLabel.visible = true
	last_score = _calc_score(enemies_killed,coins,duration)
	
	var bestScores = parse_json(BestScoresUtils.get_scores())
	var best = bestScores.pop_back()
	bestScores.push_back(best)
	
	if best == null or bestScores.size() < 5 or best["score"] < last_score:
		
		get_node("PopupDialog").popup()
	else:
		get_node("BestScoresPopup").popup()

	finalScoreLabel.text = str(last_score)

	get_tree().paused = true	

func _on_enemy_killed():
	enemies_killed = enemies_killed + 1
	$"Killed-score".text = str(enemies_killed)
	
func _calc_score(enemies_killed, ammo_left,duration):
	var ammo_factor = 100
	var enemies_killed_factor = 300
	var time_factor = duration * 0.01
	return enemies_killed * enemies_killed_factor + ammo_factor * ammo_left  - time_factor
	

func _on_TextEdit_text_changed():
	var text = get_node("PopupDialog/PlayerNameBackground/PlayerName").get_text()
	if text.find('\n') > -1:
		text = text.replace("\n","").replace(" ","")
		last_player_score = {"player":text,"score":last_score}
		BestScoresUtils.save_score(text,last_score)
		get_node("PopupDialog").hide()
		get_node("BestScoresPopup").popup()
		$Menu.stop()
	
	
func get_last_score():
	return last_player_score
	
