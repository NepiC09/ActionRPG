extends Control


	
		
#Нажали эскейп
func _input(event):
	if event.is_action_pressed("Pause"):
		get_tree().paused = not get_tree().paused
		visible =  not visible


	
#Кнопка Вернуться
func _on_Back_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible

#Сохранение
func save_level():
	FS.save_game()

#Кнопка Сохранить игру
func _on__SaveGame_pressed():
	save_level()

#Кнопка Главное меню
func _on_RerurnInMainMenu_pressed():
	get_tree().paused = false
	#FS.save_data('savedata', 'Загрузка файлов')
	save_level()
	get_tree().change_scene("res://Menu.tscn")


