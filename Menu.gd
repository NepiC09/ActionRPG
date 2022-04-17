extends Control	
#func _on_Button___pressed():
	#get_tree().change_scene("res://World.tscn")

func load_game():
	#FS.load_data()
	#print(data)
	pass
<<<<<<< HEAD

#Кнопка Продолжить игру 
=======
	
	#продолжить
>>>>>>> 0ed6456e467b2429e23b6fc5ebc3d3a29cb2bdb8
func _on_TextureButton_pressed():
	get_tree().change_scene("res://World.tscn")
	#load_game()
	pass

#Выход из игры из главного меню
func _on_Quit_pressed():
	get_tree().quit()

#начать новую игру
func _on_____pressed():
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
	pass # Replace with function body.
