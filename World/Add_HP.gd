extends Node2D

onready var soundPlayer = $AudioStreamPlayer2D

const Sound = preload("res://Player/PlayerHurtSound.tscn")

func _on_Area2D_body_entered(body):
	if(body.stats.health < body.stats.max_health):
		body.AddHealth()
		
		var sound = Sound.instance()
		sound.set_stream(AudioStreamPlayer2D)
		
		get_tree().current_scene.add_child(sound)
		
		queue_free()
