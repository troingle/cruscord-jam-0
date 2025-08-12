extends Control

@onready var hp_label = $HPContainer/HPLabel
@onready var player = $".."

func _process(delta: float) -> void:
	hp_label.text = "HEALTH: " + str(Global.hp) + "\nAMMO: " + str(Global.ammo) + "\nTOTAL AMMO: " + str(Global.reserve_ammo)
