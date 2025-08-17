extends Node3D

func _ready() -> void:
	await get_tree().create_timer(15.5).timeout
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://levels/level_1.tscn")
