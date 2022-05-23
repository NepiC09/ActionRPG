extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal CloseOptionalMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
## Настройки из ГМ
func _on__pressed():
	#get_tree().change_scene("res://Menu.tscn")
	emit_signal("CloseOptionalMenu")


func _on_HSlider_value_changed(value):
	pass#AudioServer.set_bus_volume_db(0, value)
