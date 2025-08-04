extends Control

@onready var ammo_label = $Crosshair/MarginContainer/AmmoCount

func _process(delta: float) -> void:
	ammo_label.text = " " + str(Global.ammo) + "\n " + str(Global.reserve_ammo)
