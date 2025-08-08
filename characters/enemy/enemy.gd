extends CharacterBody3D

@export var speed = 6.0
@export var accel = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav = $NavigationAgent3D

@onready var rc = $NPCHead/RayCast3D

@onready var wait_timer = $WaitTimer
@onready var failsafe_timer = $FailsafeTimer

@onready var player = $"../../Player"

var detected = true

var rng = RandomNumberGenerator.new()

var hp = 1

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if detected:
		var dir = Vector3()
		#$BodyMesh/AnimationPlayer.play("RunForward")

		nav.target_position = player.global_position

		dir = nav.get_next_path_position() - global_position
		dir.y = 0
		dir = dir.normalized()

		velocity.x = lerp(velocity.x, dir.x * speed, accel * delta)
		velocity.z = lerp(velocity.z, dir.z * speed, accel * delta)

		if not is_on_floor():
			velocity.y -= gravity * delta
		else:
			velocity.y = 0
		
		$BodyMesh.look_at(global_position + dir, Vector3.UP)
		$BodyMesh.rotation.x = 0
		
		move_and_slide()

	else:
		pass#$BodyMesh/AnimationPlayer.play("CombatIdle")
	
	
	if hp < 0:
		die()

func die():
	queue_free()
