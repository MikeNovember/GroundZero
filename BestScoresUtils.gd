static func save_score(player_name, score):
	var data = {
		player = player_name,
		score = score	
	}
	# Open a file
	var file = File.new()
	if file.open("user://saved_game.sav", File.WRITE) != 0:
    	print("Error opening file")
    #	return

# Save the dictionary as JSON (or whatever you want, JSON is convenient here because it's built-in)
	file.store_line(to_json(data))
	file.close()
	

static func get_scores():
	print("Get scores")
	var result = {}
	var save_game = File.new()
	if not save_game.file_exists("user://save_game.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		# First we need to create the object and add it to the tree and set its position.
		print(current_line)
	save_game.close()

	
	
# Note: This can be called from anywhere inside the tree. This function is path independent.

    # Load the file line by line and process that dictionary to restore the object it represents
	
const _scores_path = "user://saved_game.sav"