extends Node


#можно менять в редекаторе (задали явно тип)
export(int) var max_health = 6 setget set_max_health
var default_max_health = 6


#Позиция персонажа - обновляется при сохранении
var player_position_x = 440
var player_position_y = 480


#установка позиций (выззывается на загрузке уровня)
func set_player_position(x, y, hp):
	if hp < 1:
		max_health = default_max_health
		health = max_health
		player_position_x = 425
		player_position_y = 473
	else:
		player_position_x = x
		player_position_y = y
		health = hp


#КОСТЫЛЬ - установка хп при "Новая игра"
func set_default():
	max_health = default_max_health
	health = max_health 
	player_position_x = 425
	player_position_y = 473

#setget функция вызывающая при изменении значения переменной
#надо почитать в документах о ней
var health = max_health setget set_health


#инициализация сигналов
signal no_health
signal health_changed(value)
signal max_health_changed(value)


#установка макс хп
func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health) #i dont know wtf is this

signal ggame_over

#функция при изменении значения переменной
func set_health(value):
	health = value
	emit_signal("health_changed", health)
	#вызов сигнала
	if health <= 0: 
		emit_signal("no_health")
		#yield(get_tree().create_timer(1), "timeout")
		print("смерть1")
		#game_over()
		
func declare_GO():
	emit_signal("ggame_over")	
		
func game_over()-> void:
	if health < 1:
		var option_menu = load("res://Настрйоки.tscn").instance()
		add_child(option_menu)
		#print(get_node("Настрйоки").name)
		get_node("Настрйоки").connect("CloseOptionalMenu", self, "CloseOptionalMenu")



func CloseOptionalMenu():
	get_node("Настрйоки").queue_free()

#Установка хп изначально максимальным
func _ready():
	self.health = max_health
