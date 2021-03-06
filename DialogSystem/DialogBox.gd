extends Node2D

onready var dialogBoxText = $DialogBoxTEXT
onready var dialogBox = $DialogBox
var stats = PlayerStats

var dialog = ["Хайо, я хомяк в облике лисы...", "И я зарежу всех этих мышей потому что таков путь...", ""]
var death_dialog = "Чёртовы мыши..."
var page = 0;

func _ready():
	dialogBoxText.set_bbcode(dialog[page])
	dialogBoxText.visible_characters = 0
	dialogBoxText.set_process_input(true)
	dialogBoxText.visible = false
	dialogBox.visible = false
	stats.connect("no_health", self, "death")

func _input(event):
	if(PlayerStats.health > 0):
		if event.is_action_released("ui_accept") and dialogBoxText.visible == true:
			if dialogBoxText.visible_characters > dialogBoxText.get_total_character_count():
				if page < dialog.size() - 1:
					page += 1
					dialogBoxText.set_bbcode(dialog[page])
					dialogBoxText.visible_characters = 0
				if page >= dialog.size() - 1:
					page = 0
					dialogBoxText.set_bbcode(dialog[page])
					dialogBoxText.visible_characters = 0
					dialogBoxText.visible = false
					dialogBox.visible = false
			else: 
				dialogBoxText.visible_characters = dialogBoxText.get_total_character_count()
		if event.is_action_released("E") and dialogBoxText.visible == false:
			dialogBoxText.visible = true
			dialogBox.visible = true

func death():
	page = 0
	dialogBoxText.set_bbcode(death_dialog)
	dialogBoxText.visible_characters = 0
	dialogBoxText.visible = true
	dialogBox.visible = true
	var option_menu = load("res://Смерть КЛ.tscn").instance()
	add_child(option_menu)
	#print(get_node("Настрйоки").name)
	get_node("Смерть КЛ").connect("CloseOptionalMenu", self, "CloseOptionalMenu")

func CloseOptionalMenu():
	get_node("Смерть КЛ").queue_free()


func _on_Timer_timeout():
	if dialogBoxText.visible == true:
		dialogBoxText.visible_characters += 1
