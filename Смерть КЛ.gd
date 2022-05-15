extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on__New___pressed():
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
	print("новая игра")


func _on_Main__pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_Player_sq():
	print("qqq")
