extends Node3D

@onready var raycast: RayCast3D = $"../RayCast3D"
@onready var weapon_point: Node3D = $"WeaponPoint"

@export var raycast_length: float = 1000.0
@export var dropped_weapon_scene: PackedScene

var weapon: Weapon

func _ready() -> void:
	raycast.target_position = Vector3(0, 0, -raycast_length)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") and weapon != null:
		weapon.process_input(event)

func switch_weapon(new_weapon_scene: PackedScene) -> void:
	drop_weapon()
	var new_weapon = new_weapon_scene.instantiate() as Weapon
	weapon_point.add_child(new_weapon)
	weapon = new_weapon


func drop_weapon() -> DroppedWeapon:
	if weapon != null:
		var dropped_weapon = dropped_weapon_scene.instantiate()
		weapon_point.remove_child(weapon)
		dropped_weapon.set_weapon_scene(weapon)
		dropped_weapon.position = weapon_point.global_position
		$"/root/Scene/World".add_child(dropped_weapon)
		weapon = null
		return dropped_weapon
	return null
