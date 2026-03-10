extends Node3D

@onready var raycast: RayCast3D = $"../RayCast3D"
@onready var weapon: Weapon = $"./WeaponPoint/Weapon" as Weapon

@export var raycast_length: float = 1000.0

func _ready() -> void:
	raycast.target_position = Vector3(0, 0, -raycast_length)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") and weapon != null:
		weapon.process_input(event)

func switch_weapon(new_weapon_scene: PackedScene) -> void:
	if weapon != null:
		weapon.queue_free()
	var new_weapon = new_weapon_scene.instantiate() as Weapon
	add_child(new_weapon)
	weapon = new_weapon


func drop_weapon() -> void:
	if weapon != null:
		weapon.queue_free()
		weapon = null
