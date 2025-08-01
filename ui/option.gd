extends PanelContainer

@onready var option_label = $OptionLabel
@onready var dialogue_box = $"../../../../../../../../.."

func _process(delta: float) -> void:
	if option_label.text == "":
		visible = false
	else:
		visible = true

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		dialogue_box.choose_option(option_label.text)
