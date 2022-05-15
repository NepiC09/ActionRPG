extends Control

#Выход из игры из главного меню
func _on_Quit_pressed():
	get_tree().quit()

#нажата Новая Игра
func _on_____pressed():
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()

# Настройки
func _on___pressed():
	var option_menu = load("res://Настрйоки.tscn").instance()
	add_child(option_menu)
	print(get_node("Настрйоки").name)
	get_node("Настрйоки").connect("CloseOptionalMenu", self, "CloseOptionalMenu")

func CloseOptionalMenu():
	get_node("Настрйоки").queue_free()
