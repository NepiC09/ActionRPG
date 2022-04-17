extends Node

#Название файла, где будут сохранены все параметры
var save_filename="user://save_game"
var game_data = {}


func save_game():
	print("Сохранение")
	var save_file = File.new()
	save_file.open(save_filename, File.WRITE)
	#game_data = Player.get_save_stats()
	#print(game_data.name)
	#var saved_nodes = get_tree().get_nodes_in_group("Saved")
#	for node in saved_nodes:
		#print("t54")
		#if node.filename.empty():
			#break
					
	#var node_details = PlayerStats.node.get_save_stats()
	##save_file.store_line(to_json(node_details))
		
	save_file.store_string(to_json(game_data))
	save_file.store_string("QQQQQQQQQQQQ")
	print("Сохр")
	save_file.close()
	
	
	
	
	
	
	
	
func load_data():
	var file = File.new()
	file.open(save_filename, File.READ)
	game_data = file.get_var()
	
	
	
	
#func _notification(what):
	#if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		#save_game()
		#pass
