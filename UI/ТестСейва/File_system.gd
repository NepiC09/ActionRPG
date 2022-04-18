extends Node

#Название файла, где будут сохранены все параметры
var save_filename="user://save_game.txt"
var game_data = {}
var World = load("res://World.tscn")

	
func save_game():
	print("Сохранение")
	var save_file = File.new()
	save_file.open(save_filename, File.WRITE)
	#game_data = Player.get_save_stats()
	#print(game_data.name)
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	for node in saved_nodes:
		#print("t54")
		if node.filename.empty():
			break
					
		var node_details = node.get_save_stats()
		save_file.store_line(to_json(node_details))
		
	#save_file.store_string(to_json(game_data))
	#save_file.store_string("QQQQQQQQQQQQ")
	save_file.close()
	
	
	
func load_game():
	var file = File.new()
	if not file.file_exists(save_filename):
		print("File Not Exist")
	
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	for node in saved_nodes:
		node.queue_free()

	file.open(save_filename, File.READ)
	while file.get_position()<file.get_len():	
		var node_data = parse_json(file.get_line())
		PlayerStats.set_player_position(node_data.x_pos, node_data.y_pos)
	file.close()
