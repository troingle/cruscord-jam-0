extends CharacterBody3D

@export var speed = 6.0
@export var accel = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav = $NavigationAgent3D

@onready var player_detector = $EnemyHead/PlayerDetector
@onready var shooting_rc = $ShootingRC

@onready var wait_timer = $WaitTimer
@onready var failsafe_timer = $FailsafeTimer
@onready var shoot_timer = $ShootTimer

@onready var player = $"../../Player"

var detected = false

var rng = RandomNumberGenerator.new()

@export var hp = 1
@export var damage = 10
@export var fire_rate = 0.8


var rotate_speed = 150.0

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
		
		shooting_rc.look_at(player.global_position)
		shooting_rc.rotation.x = 0
	else:
		$EnemyHead.rotation_degrees.y += rotate_speed * delta
		if player_detector.is_colliding():
			if player_detector.get_collider().is_in_group("player"):
				detected = true
				shoot_timer.wait_time = fire_rate
				shoot_timer.start()
			
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

func _on_shoot_timer_timeout() -> void:
	if shooting_rc.is_colliding():
		if shooting_rc.get_collider().is_in_group("player"):
			Global.hp -= damage
