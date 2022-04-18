extends Control

#Выход из игры из главного меню
func _on_Quit_pressed():
	get_tree().quit()


func _on_____pressed():
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
