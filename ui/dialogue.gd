extends PanelContainer

@onready var dialogue = DialogueSource.dialogue

@onready var name_label = $MarginContainer/HBoxContainer/LeftSide/VBoxContainer/NameLabel
@onready var speech_label = $MarginContainer/HBoxContainer/LeftSide/VBoxContainer/SpeechStuff/SpeechLabel

@onready var player = $"../.."

var current_npc = ""
var current_npc_obj : CharacterBody3D

func open_dialogue(npc_name, first_time):
	current_npc = npc_name
	show()
	$"../LeaveButton".show()
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
	var log_entry = current_npc + ": " + dialogue[current_npc]["choices"][option][0] + "\n---\n"
	if log_entry not in Global.log_text:
		Global.log_text = log_entry + Global.log_text
		
	if dialogue[current_npc]["choices"][option][2] != "":
		var thought_entry = dialogue[current_npc]["choices"][option][2] + "\n---\n"
		if thought_entry not in Global.log_text:
			Global.log_text = thought_entry + Global.log_text
		
	open_dialogue(current_npc, false)
	
func close():
	hide()
	$"../LeaveButton".hide()
	if current_npc_obj:
		current_npc_obj.stop_movement()
	
