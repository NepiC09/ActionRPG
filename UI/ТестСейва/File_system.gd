extends Node

#Название файла, где будут сохранены все параметры
var save_filename="user://save_game.txt"
var game_data = {}

func _ready():
	load_game()
	
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
		print("rdgfasrgreag")
		return
	print("ЗАГРУЗКА ИГРЫ")
	
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	for node in saved_nodes:
		node.queue_free()

	file.open(save_filename, File.READ)
	while file.get_position()<file.get_len():	
		var node_data = parse_json(file.get_line())
		print("КОРДЫ ИЗ ФАЙЛА ",node_data.x_pos, " ", node_data.y_pos)
		var new_obj = load(node_data.filename).instance()
		get_node(node_data.parent)#.call_deferred('add_child', new_obj)
		new_obj.load_save_stats(node_data)
			
	file.close()
		

	
		
		
		
		
#func _notification(what):
	#if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		#save_game()
		#pass
