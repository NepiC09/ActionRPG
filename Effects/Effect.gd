extends AnimatedSprite

func _ready():
	#связываем метод с сигналом
# warning-ignore:return_value_discarded
	connect("animation_finished", self, "_on_animation_finished")
	#задаём начальный фрейм анимации
	frame = 0
	#включаем анимацию
	play("animate")

#связанная функция с сигналом
func _on_animation_finished():
	#удаляем нод
	queue_free()
