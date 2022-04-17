extends Control	
#func _on_Button___pressed():
	#get_tree().change_scene("res://World.tscn")

func load_game():
	#FS.load_data()
	#print(data)
	pass
	
	#продолжить
func _on_TextureButton_pressed():
	get_tree().change_scene("res://World.tscn")
	#load_game()
	pass

func _on_Quit_pressed():
	get_tree().quit()

#начать новую игру
func _on_____pressed():
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
	pass # Replace with function body.
