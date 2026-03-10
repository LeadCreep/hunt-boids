extends Interractable
class_name DroppedWeapon

var on_floor: bool = false

@export var weapon_scene: PackedScene

var weapon_instance: Weapon


func _ready() -> void:
	if weapon_scene != null:
		weapon_instance = weapon_scene.instantiate() as Weapon
		add_child(weapon_instance)
		weapon_instance.get_child(0).position = Vector3(0, 0, 0)


func set_weapon_scene(weapon: Weapon) -> void:
	call_deferred("add_child", weapon)
	weapon.get_child(0).position = Vector3(0, 0, 0)
	weapon_instance = weapon
	weapon_scene = PackedScene.new()
	weapon_scene.pack(weapon)


func _process(delta: float) -> void:
	if on_floor:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var collision_info = move_and_collide(velocity * delta)
	if collision_info && !on_floor:
		if collision_info.get_collider() is Boid:
			collision_info.get_collider().get_hit()
			if get_child(1).name != "WeaponAxe":
				queue_free()
		else:
			on_floor = true
			velocity = Vector3.ZERO

	if velocity.length() > 0.1 and weapon_instance != null and weapon_instance.weapon_type == Weapon.WeaponType.THROWABLE:
		rotation.y += delta * 10.0
		rotation.x += delta * 10.0
		rotation.z += delta * 10.0

func get_used(_inv: Inventory) -> void:
	if _inv.counter_capsule < price:
		return
	_inv.counter_capsule -= price
	_inv.inventory_ui.update_ui(_inv)
	price = 0
	_inv.add_weapon(weapon_scene)
	queue_free()


func trow(direction: Vector3, force: float) -> void:
	velocity = direction.normalized() * force
