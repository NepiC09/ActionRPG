extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	pass
	#print(global_transform.origin.x, "  ", global_transform.origin.y)


func get_save_stats():
	print("G___________")
	#print(global_transform.origin.x)
	#print(global_transform.origin.y)
	print("ПРИНТПЛ___________")
	return {
		"filename" : get_filename(),
		"x_pos" : global_transform.origin.x,
		"y_pos" : global_transform.origin.y,

	}
