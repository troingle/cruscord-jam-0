extends CharacterBody3D

@export var npc_name = "Test NPC"
@export var wandering = true

var speed = 6.0
var accel = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav = $NavigationAgent3D

@onready var rc = $NPCHead/RayCast3D

@onready var wait_timer = $WaitTimer
@onready var failsafe_timer = $FailsafeTimer

var target_pos = Vector3.ZERO
var on_the_move = false

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	find_new_target_pos()

func _physics_process(delta: float) -> void:
	if on_the_move:
		var dir = Vector3()

		nav.target_position = target_pos

		dir = nav.get_next_path_position() - global_position
		dir.y = 0
		dir = dir.normalized()

		velocity.x = lerp(velocity.x, dir.x * speed, accel * delta)
		velocity.z = lerp(velocity.z, dir.z * speed, accel * delta)

		if not is_on_floor():
			velocity.y -= gravity * delta
		else:
			velocity.y = 0
			
		move_and_slide()

		if global_position.distance_to(target_pos) < 2.5:
			stop_movement()
			
	$"../../Marker".global_position = target_pos

func find_new_target_pos():
	var end_point = rc.global_position + rc.global_transform.basis.z * rc.target_position.z
	
	randomize()
	rc.target_position.z = rng.randf_range(5.0, 20.0)
	$NPCHead.rotation.y = rng.randf_range(-180.0, 180.0)
	target_pos = end_point
	on_the_move = true
	failsafe_timer.start()
	
func stop_movement():
	on_the_move = false
	randomize()
	wait_timer.wait_time = rng.randf_range(2.0, 8.5)
	wait_timer.start()
	failsafe_timer.stop()

func _on_wait_timer_timeout() -> void:
	find_new_target_pos()
	
func _on_detect_wall_body_entered(body: Node3D) -> void:
	stop_movement()

func _on_failsafe_timer_timeout() -> void:
	stop_movement()
	print("FAILSAFE ACTIVATED")
