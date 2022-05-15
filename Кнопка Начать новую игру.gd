extends TextureButton

onready var Fade_In_Object = get_parent().get_node("Fade_In")
onready var AnimationPlayerObject = get_parent().get_node("Fade_In/AnimationPlayer")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_____pressed():
	Fade_In_Object.visible = true
	AnimationPlayerObject.play("Fade_In")
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
