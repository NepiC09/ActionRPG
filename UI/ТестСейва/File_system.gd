extends Node

#var input_vectorG = get_node("/root/PlayerStats")

var files = File.new()
var dirs = Directory.new()

func save_data():
	files.open("user://save_game", File.WRITE)
	#files.store_string(to_json(data))
	var data = {
		#"IV_x": input_vectorG.x,
		#"IV_y": input_vectorG.y
	}
	files.close()
	#print('Произошло сохранение', " ",input_vectorG.x, " ", input_vectorG.y)
	
	
func load_data():
	files.open("user://save_game", File.READ)
	var data = files.get_var()
	#input_vectorG.x=data["IV_x"]
	#input_vectorG.y=data["IV_y"]
	files.close()


