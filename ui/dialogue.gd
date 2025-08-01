extends PanelContainer

@onready var dialogue = DialogueSource.dialogue

@onready var name_label = $MarginContainer/HBoxContainer/LeftSide/VBoxContainer/NameLabel
@onready var speech_label = $MarginContainer/HBoxContainer/LeftSide/VBoxContainer/SpeechStuff/SpeechLabel

@onready var player = $"../.."

var current_npc = ""

func open_dialogue(npc_name, first_time):
	current_npc = npc_name
	show()
	name_label.text = current_npc
	
	if first_time:
		speech_label.text = dialogue[current_npc]["start_dialogue"]
	
	var choices = dialogue[current_npc]["choices"]
	var options = get_tree().get_nodes_in_group("option")
	
	for o in options:
		o.option_label.text = ""

	var option_num = 0
	for c in choices:
		if player.check_requirement(choices[c][1]):
			options[option_num].option_label.text = c
			option_num += 1
	
func choose_option(option):
	speech_label.text = dialogue[current_npc]["choices"][option][0]
	open_dialogue(current_npc, false)
	
