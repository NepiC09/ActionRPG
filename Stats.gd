extends Node

#можно менять в редекаторе (задали явно тип)
export(int) var max_health = 6 setget set_max_health

var default_max_health = 6

#Позиция персонажа - обновляется при сохранении
var player_position_x = 440
var player_position_y = 480

#установка позиций (выззывается на загрузке уровня)
func set_player_position(x, y):
	player_position_x = x
	player_position_y = y

#КОСТЫЛЬ - установка хп при "Новая игра"
func set_default():
	max_health = default_max_health
	health = max_health

#setget функция вызывающая при изменении значения переменной
#надо почитать в документах о ней
var health = max_health setget set_health

#инициализация сигнала
signal no_health

signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

#функция при изменении значения переменной
func set_health(value):
	health = value
	emit_signal("health_changed", health)
	#вызов сигнала
	if health <= 0: 
		emit_signal("no_health")

func _ready():
	self.health = max_health
