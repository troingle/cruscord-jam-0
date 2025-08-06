extends CharacterBody3D

var movement_speed = 0.0
@export var speed = 6.6
@export var crouch_speed = 6.6
@export var accel = 4.7
@export var jump_velocity = 10.0
@export var sensitivity = 0.1
@export var min_angle = -80
@export var max_angle = 90

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var interact_rc = $Head/InteractRC
@onready var filter = $CanvasLayer/ColorLimit

@onready var dialogue_box = $UI/DialogueBox
@onready var leave_button = $UI/LeaveButton

@onready var gun_cooldown_timer = $Timers/GunCooldown
@onready var gun_rc = $Head/GunRC
@onready var reload_timer = $Timers/ReloadTimer

var input_dir

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var look_rot : Vector2
var stand_height : float

var bob_freq = 1.5
var bob_amp = 0.1
var t_bob = 0.0

var normal_head_pos = 3.464
var crouch_head_pos = 1.91

var gun_on_cooldown = false

func _ready() -> void:
	dialogue_box.open_dialogue("Test NPC", true)
	dialogue_box.close()

func _input(event):
	if event is InputEventMouseMotion:
		look_rot.y -= (event.relative.x * sensitivity)
		look_rot.x -= (event.relative.y * sensitivity)
		look_rot.x = clamp(look_rot.x, min_angle, max_angle)
		
func _physics_process(delta):
	if not dialogue_box.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		head.rotation_degrees.x = look_rot.x
		rotation_degrees.y = look_rot.y
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	if dialogue_box.visible:
		input_dir = Vector2(0, 0)
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
	velocity.x = lerp(velocity.x, direction.x * movement_speed, accel * delta)
	velocity.z = lerp(velocity.z, direction.z * movement_speed, accel * delta)
	
	move_and_slide()

	if Input.is_action_pressed("exit") and dialogue_box.visible:
		dialogue_box.close()
		
	if Input.is_action_just_pressed("interact") and interact_rc.is_colliding():
		var collider = interact_rc.get_collider()
		if collider.is_in_group("friendly_npc"):
			dialogue_box.open_dialogue(collider.npc_name, true)
			dialogue_box.current_npc_obj = collider
			collider.on_the_move = false
		
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = headbob(t_bob)
	
	$UI/ChatLog/VBoxContainer/MarginContainer/ScrollContainer/LogText.text = Global.log_text
	if Input.is_action_just_pressed("tab"):
			$UI/ChatLog.visible = not $UI/ChatLog.visible
			
	if Input.is_action_pressed("crouch"):
		head.position.y = crouch_head_pos
		movement_speed = crouch_speed
	else:
		head.position.y = normal_head_pos
		movement_speed = speed
	
	$UI/Crosshair/BarContainer/Bar.scale.x = gun_cooldown_timer.time_left * 0.65
	
	# GUNS
	gun_rc.target_position.z = -Guns.guns[Global.gun]["range"]
		
	if Input.is_action_pressed("shoot") and not gun_on_cooldown and (Global.ammo > 0 or not Guns.guns[Global.gun]["requires_ammo"]):
		gun_on_cooldown = true
		if gun_rc.is_colliding():
			var target = gun_rc.get_collider()
			target.hp -= Guns.guns[Global.gun]["damage"]
		
		if Guns.guns[Global.gun]["requires_ammo"]:
			Global.ammo -= 1
		gun_cooldown_timer.wait_time = Guns.guns[Global.gun]["cooldown"]
		gun_cooldown_timer.start()
		
	if Input.is_action_just_pressed("reload") and Global.ammo < Guns.guns[Global.gun]["max_ammo"]:
		reload_timer.start()
	
func check_requirement(num):
	if num == 0:
		return true
	return false

func headbob(time):
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	return pos

func _on_gun_cooldown_timeout() -> void:
	gun_on_cooldown = false

func _on_reload_timer_timeout() -> void:
	Global.reserve_ammo -= abs(Guns.guns[Global.gun]["max_ammo"] - Global.ammo)
	Global.ammo = Guns.guns[Global.gun]["max_ammo"]
	
	
