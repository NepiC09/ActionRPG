extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func dead():
	print("DEAAD")
	#get_tree().paused = not get_tree().paused
	visible =  not visible
