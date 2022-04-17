extends Node2D

const Sound = preload("res://UI/HealthSound.tscn")

func _on_Area2D_body_entered(body):
	if(body.stats.health < body.stats.max_health):
		body.AddHealth()
		
		var sound = Sound.instance()
		get_tree().current_scene.add_child(sound)
		queue_free()
