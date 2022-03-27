extends Node2D
#предзагружаем сцену сразу, чтобы не загружать её постоянно 
const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
	#получаем данные сцены
	var grassEffect = GrassEffect.instance()
	#создаём у родителя ребёнка - grassEffect
	get_parent().add_child(grassEffect)
	#на всякий случай (?)
	grassEffect.global_position = global_position

#когда арена входит в арену
func _on_Hurtbox_area_entered(_area):
	#вызываем функцию
	create_grass_effect()
	#удаляем обект
	queue_free()
