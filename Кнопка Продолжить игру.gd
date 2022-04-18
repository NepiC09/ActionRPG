extends TextureButton

onready var Fade_In_Object = get_parent().get_node("Fade_In")
onready var AnimationPlayerObject = get_parent().get_node("Fade_In/AnimationPlayer")

func _ready():
	Fade_In_Object.visible = false


func _on____pressed():
	Fade_In_Object.visible = true
	AnimationPlayerObject.play("Fade_In")
	yield(get_tree().create_timer(0.5), "timeout")
	FS.load_game()
	get_tree().change_scene("res://World.tscn")
	pass
