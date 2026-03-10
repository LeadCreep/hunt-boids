extends Node3D
class_name Weapon

enum WeaponType {
	THROWABLE,
	RANGED
}

@export var weapon_type: WeaponType = WeaponType.THROWABLE

func _get_view_direction(head: Node3D, camera: Camera3D) -> Vector3:
	var yaw := head.global_rotation.y
	var pitch := camera.rotation.x

	var cos_pitch := cos(pitch)
	var direction := Vector3(
		- sin(yaw) * cos_pitch,
		sin(pitch),
		- cos(yaw) * cos_pitch
	)

	return direction.normalized()

func process_input(_event: InputEvent) -> void:
	if weapon_type == WeaponType.THROWABLE:
		var head: Node3D = $"../../../../../Head"
		var camera: Camera3D = $"../../../../Camera3D"
		var direction := _get_view_direction(head, camera)
		var dropped_weapon: DroppedWeapon = $"../../../WeaponManager".drop_weapon()
		if dropped_weapon != null:
			dropped_weapon.trow(direction, 30.0)
	elif weapon_type == WeaponType.RANGED:
		var raycast: RayCast3D = $"../../../RayCast3D"
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider.has_method("get_hit"):
				collider.get_hit()
