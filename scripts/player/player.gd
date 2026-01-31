extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.005

#bob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

@export var bobing: bool = true
@export var bobing_lr: bool = false

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var weapon_manager = $Head/Camera3D/WeaponManager
@onready var weapon_point = $Head/Camera3D/WeaponManager/WeaponPoint

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90));
	
	# TODO retirer plus tard
	if event.is_action_pressed("escape"):
		get_tree().quit()
	
	if event.is_action_pressed("inventory"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.is_action_pressed("ui_accept"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta;

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY;

	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED;
	else:
		speed = WALK_SPEED;

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * -speed;
		velocity.z = direction.z * -speed;
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	t_bob += delta * velocity.length() * float(is_on_floor());
	camera.transform.origin = _headbob(t_bob);
	weapon_manager.transform.origin = _headbob(t_bob);

	#FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO;
	pos.y = sin(time * BOB_FREQ) * BOB_AMP * int(bobing);
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP * int(bobing_lr);
	return pos
