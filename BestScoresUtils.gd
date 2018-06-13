class ScoresSorter:
	static func sort(a,b):
		if a["score"] > b["score"]:
			return true
		return false
		
const max_best_scores = 5

static func save_score(player_name, score):
	
	var my_data = parse_json(get_scores())
	var player_score = {"player":player_name, "score":score}
	if my_data.size() < max_best_scores:
		my_data.append(player_score)
	else:
		var back = my_data.back()
		if back["score"] < score:
			my_data.pop_back()
			my_data.append(player_score)
		else:
			return
	
	# Open a file
	var dir = Directory.new()
	dir.remove(_scores_path)
	var file = File.new()
	if file.open(_scores_path, File.WRITE) != 0:
    	print("Error opening file")


	my_data.sort_custom(ScoresSorter,"sort")
	file.store_var(to_json(my_data))
	file.close()
	

static func get_scores():
	var result = {}
	var save_game = File.new()
	if not save_game.file_exists(_scores_path):
		return "[]" # Error! We don't have a save to load.
	save_game.open(_scores_path, File.READ)
	
	var scores = save_game.get_var()
	save_game.close()
	return scores

	
const _scores_path = "user://best-scores.save"