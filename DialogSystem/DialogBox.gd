extends Node2D

onready var dialogBoxText = $DialogBoxTEXT
onready var dialogBox = $DialogBox

var dialog = ["Хайо, я хомяк в облике лисы...", "И я зарежу всех этих мышей потому что такова игра...", ""]
var page = 0;

func _ready():
	dialogBoxText.set_bbcode(dialog[page])
	dialogBoxText.visible_characters = 0
	dialogBoxText.set_process_input(true)
	dialogBoxText.visible = false
	dialogBox.visible = false
	

func _input(event):
	if event.is_action_pressed("ui_accept") and dialogBoxText.visible == true:
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
		
	if event.is_action_pressed("E"):
		dialogBoxText.visible = true
		dialogBox.visible = true


func _on_Timer_timeout():
	if dialogBoxText.visible == true:
		dialogBoxText.visible_characters += 1
