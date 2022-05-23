extends Control

onready var Fade_In_Object = get_parent().get_node("Fade_In")
onready var AnimationPlayerObject = get_parent().get_node("Fade_In/AnimationPlayer")

func _ready():
	if PlayerStats.health <1:
		Fade_In_Object.visible = false
		Fade_In_Object.visible = true
		#yield(get_tree().create_timer(2), "timeout")
		AnimationPlayerObject.play("Fade_In")
		yield(get_tree().create_timer(1), "timeout")
		visible = not visible
		print('hp: ', PlayerStats.health)
		print('x: ', PlayerStats.player_position_x)
		print('y: ', PlayerStats.player_position_y)
		#FS.save_game()


signal s

# главное меню
func _on___pressed():
	#queue_free()
	#print("гл")
	#get_tree().paused = false
	#FS.save_data('savedata', 'Загрузка файлов')
	##save_level()
	get_tree().change_scene("res://Menu.tscn")
	emit_signal("s")
	#get_node("root/Stats/Смерть КЛ").queue_free()

func _on_Main__pressed():
	#print(PlayerStats.health)
	#FS.save_game()
	get_tree().change_scene("res://Menu.tscn")


#новая игра после смерти
func _on__NewGame___pressed():
	#get_tree().change_scene("res://World.tscn")
	#PlayerStats.set_default()
	Fade_In_Object.visible = true
	AnimationPlayerObject.play("Fade_In")
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
	pass
