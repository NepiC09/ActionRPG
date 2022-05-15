extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

onready var Fade_In_Object = get_parent().get_node("Fade_In")
onready var AnimationPlayerObject = get_parent().get_node("Fade_In/AnimationPlayer")

func _ready():
	if PlayerStats.health <1:
		Fade_In_Object.visible = false
		Fade_In_Object.visible = true
		#yield(get_tree().create_timer(2), "timeout")
		AnimationPlayerObject.play("Fade_In")
		yield(get_tree().create_timer(1), "timeout")
		visible = not visible
		print("cvthrtewghw4ehwregh")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

signal s
# главное меню
func _on___pressed():
	#queue_free()
	#print("гл")
	#get_tree().paused = false
	#FS.save_data('savedata', 'Загрузка файлов')
	##save_level()
	get_tree().change_scene("res://Menu.tscn")
	emit_signal("s")
	#get_node("root/Stats/Смерть КЛ").queue_free()

##новая игра
func _on_____pressed():
	#dvisible = not visible
	#queue_free()
	get_tree().change_scene("res://World.tscn")
	PlayerStats.set_default()
	#print("новая игра")
	emit_signal("s")
	#get_node("Смерть КЛ").queue_free()
