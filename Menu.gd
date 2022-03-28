extends Control	
#func _on_Button___pressed():
	#get_tree().change_scene("res://World.tscn")


func _on_TextureButton_pressed():
	get_tree().change_scene("res://World.tscn")



func _on_Quit_pressed():
	get_tree().quit()
