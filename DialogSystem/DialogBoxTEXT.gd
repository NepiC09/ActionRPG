extends RichTextLabel

var dialog = ["Хайо, я хомяк в облике лисы...", "И я зарежу всех этих мышей потому что такова игра..."]
var page = 0;

func _ready():
	set_bbcode(dialog[page])
	visible_characters = 0
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if(visible_characters > get_total_character_count()):
			if page < dialog.size() - 1:
				page+=1
				set_bbcode(dialog[page])
				visible_characters = 0

func _on_Timer_timeout():
	visible_characters += 1
