extends RigidBody3D

@onready var camera = $Camera3D

func _ready() -> void:
	apply_impulse(Vector3(8.0 * [-1, 1].pick_random(), 6.0, 8.0 * [-1, 1].pick_random()))
