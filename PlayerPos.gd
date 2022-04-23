extends Node2D

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
