extends CharacterBody3D

@export var speed = 6.0
@export var accel = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav = $NavigationAgent3D

@onready var player_detector = $EnemyHead/PlayerDetector

@onready var wait_timer = $WaitTimer
@onready var failsafe_timer = $FailsafeTimer

@onready var player = $"../../Player"

var detected = false

var rng = RandomNumberGenerator.new()

var hp = 1

var rotate_speed = 140.0

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var dir = Vector3()
	#$BodyMesh/AnimationPlayer.play("RunForward")

	nav.target_position = player.global_position
	
	if detected:
		dir = nav.get_next_path_position() - global_position
		dir.y = 0
		dir = dir.normalized()

		velocity.x = lerp(velocity.x, dir.x * speed, accel * delta)
		velocity.z = lerp(velocity.z, dir.z * speed, accel * delta)
	else:
		$EnemyHead.rotation_degrees.y += rotate_speed * delta
		if player_detector.is_colliding():
			if player_detector.get_collider().is_in_group("player"):
				detected = true
			

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	
	$BodyMesh.look_at(global_position + dir, Vector3.UP)
	$BodyMesh.rotation.x = 0
	
	if hp < 0:
		die()
		
	move_and_slide()
	
func die():
	queue_free()
