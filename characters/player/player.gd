extends CharacterBody3D

var movement_speed = 0.0
var speed = 8.0
var crouch_speed = 4.5
var run_speed = 14.0
var accel = 4.7

@export var jump_velocity = 10.0
var sensitivity = 0.1
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

@onready var pause_screen = $UI/PauseScreen

@onready var death_head_obj = load("res://misc_nodes/death_head.tscn")

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
var dead = false

func _ready() -> void:
	dialogue_box.open_dialogue("Test NPC", true)
	dialogue_box.close()

func _input(event):
	if event is InputEventMouseMotion:
		look_rot.y -= (event.relative.x * sensitivity)
		look_rot.x -= (event.relative.y * sensitivity)
		look_rot.x = clamp(look_rot.x, min_angle, max_angle)
		
func _physics_process(delta):
	if dead: return

	
	if not dialogue_box.visible and not pause_screen.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		head.rotation_degrees.x = look_rot.x
		rotation_degrees.y = look_rot.y
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	# MOVEMENT & GENERAL STUFF
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
	
	if Input.is_action_pressed("crouch"):
		head.position.y = crouch_head_pos
		movement_speed = crouch_speed
	elif Input.is_action_pressed("run"):
		head.position.y = normal_head_pos
		movement_speed = run_speed
	else:
		head.position.y = normal_head_pos
		movement_speed = speed

	# UI STUFF
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
	
	#$UI/Crosshair/BarContainer/Bar.scale.x = gun_cooldown_timer.time_left * 0.65
	
	if Input.is_action_just_pressed("exit"):
		pause_screen.visible = !pause_screen.visible
	
	sensitivity = $UI/PauseScreen/VBoxContainer/HSlider.value
	
	# SOUND
	if direction and is_on_floor():
		$Audio/Footsteps.volume_db = 0.0
	else:
		$Audio/Footsteps.volume_db = -9999.0
	
	# GUNS
	gun_rc.target_position.z = -Guns.guns[Global.gun]["range"]
		
	if Input.is_action_pressed("shoot") and not gun_on_cooldown and (Global.ammo > 0 or not Guns.guns[Global.gun]["requires_ammo"]) and not dialogue_box.visible and not pause_screen.visible:
		gun_on_cooldown = true
		$Audio/ShootPistol.play()
		$Anims/Shoot.play("pistol_shoot")
		if gun_rc.is_colliding():
			if gun_rc.get_collider().is_in_group("killable"):
				var target = gun_rc.get_collider()
				target.hp -= Guns.guns[Global.gun]["damage"]
		
		if Guns.guns[Global.gun]["requires_ammo"]:
			Global.ammo -= 1
		gun_cooldown_timer.wait_time = Guns.guns[Global.gun]["cooldown"]
		gun_cooldown_timer.start()
		
	if Input.is_action_just_pressed("reload") and Global.ammo < Guns.guns[Global.gun]["max_ammo"]:
		reload_timer.start()
		$Audio/ReloadPistol.play()
		
	if Input.is_action_just_pressed("zoom"):
		$Zoom.play("zoom_in")
	if Input.is_action_just_released("zoom"):
		$Zoom.play("zoom_out")
		
	if Global.hp <= 0:
		die()
		
func die():
	dead = true
		
	var death_head = death_head_obj.instantiate()
	$"..".add_child(death_head)
	death_head.global_position = head.global_position
	death_head.camera.current = true
	
	var quote = DialogueSource.quotes.pick_random()
	$UI/DeathMsg.text = '"' + quote[0] + '"\n- ' + quote[1]
	
	$Audio/Footsteps.volume_db = -9999.0
	$UI/DeathMsg.show()
	$UI/UIBorder.hide()
	$UI/DialogueBox.hide()
	$UI/ChatLog.hide()
	$UI/AmmoInfo.hide()
	$UI/HPContainer.hide()
	$UI/Crosshair.hide()
	$UI/AmmoContainer.hide()
	$Head/Weapon.hide()
	
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
	if Global.reserve_ammo > 0:
		Global.reserve_ammo -= abs(Guns.guns[Global.gun]["max_ammo"] - Global.ammo)
		Global.ammo = Guns.guns[Global.gun]["max_ammo"]
	if Global.reserve_ammo < 0:
		Global.reserrve_ammo = 0
		
	
	
