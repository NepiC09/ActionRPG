extends Node2D


func _on_Area2D_body_entered(body):
	if(body.stats.health < body.stats.max_health):
		body.AddHealth()
		queue_free()
	else:
		pass
