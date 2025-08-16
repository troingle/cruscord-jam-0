extends Control

@onready var hp_label = $HPContainer/HPLabel
@onready var ammo_label = $AmmoContainer/AmmoLabel
@onready var player = $".."

func _process(delta: float) -> void:
	hp_label.text = str(Global.hp)
	ammo_label.text = str(Global.ammo) + " / " + str(Global.reserve_ammo)
