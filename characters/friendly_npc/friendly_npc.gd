extends CharacterBody3D

@export var wandering = true

var speed = 6.0
var accel = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav = $NavigationAgent3D

@onready var rc = $NPCHead/RayCast3D
@onready var end_point = $NPCHead/RayCast3D/EndPoint
@onready var wait_timer = $WaitTimer

var target_pos = Vector3.ZERO
var on_the_move = false

var rng = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	if on_the_move:
		var dir = Vector3()
		
		nav.target_position = target_pos
		
		dir = nav.get_next_path_position() - global_position
		dir = dir.normalized()
		
		if not is_on_floor():
			velocity.y -= gravity * delta
			dir.y = 0
		
		velocity = velocity.lerp(dir * speed, accel * delta)
		
		move_and_slide()
		
		if global_position.distance_to(target_pos) < 1.5:
			on_the_move = false
			randomize()
			wait_timer.wait_time = rng.randf_range(2.0, 8.0)
			print("ahg")
			wait_timer.start()

func find_new_target_pos():
	randomize()
	$NPCHead.rotation.y = rng.randf_range(0.0, 360.0)
	if not rc.is_colliding():
		target_pos = end_point.global_position
		on_the_move = true
		print(target_pos)
	else: # something is in the way, FIX THIS !!!!!s
		#find_new_target_pos()
		print("finding new")

func _on_wait_timer_timeout() -> void:
	find_new_target_pos()
	
