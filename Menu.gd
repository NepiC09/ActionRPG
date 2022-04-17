extends Control	
#func _on_Button___pressed():
	#get_tree().change_scene("res://World.tscn")

func load_game():
	#FS.load_data()
	#print(data)
	pass

#Кнопка Продолжить игру 
func _on_TextureButton_pressed():
	get_tree().change_scene("res://World.tscn")
	#load_game()
	pass

#Выход из игры из главного меню
func _on_Quit_pressed():
	get_tree().quit()



func _on_____pressed():
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
