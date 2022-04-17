extends Control	
#func _on_Button___pressed():
	#get_tree().change_scene("res://World.tscn")

func load_game():
	FS.load_game()

#Кнопка Продолжить игру 
func _on_TextureButton_pressed():
	load_game()
	get_tree().change_scene("res://World.tscn")

#Выход из игры из главного меню
func _on_Quit_pressed():
	get_tree().quit()



func _on_____pressed():
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
