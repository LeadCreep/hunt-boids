extends Interractable

var on_floor: bool = false

@export var weapon_scene: PackedScene

func _ready() -> void:
	if weapon_scene != null:
		var weapon_instance = weapon_scene.instantiate() as Weapon
		add_child(weapon_instance)
		weapon_instance.rotation = Vector3(0, 0, 0)


func set_weapon_scene(new_weapon_scene: PackedScene) -> void:
	weapon_scene = new_weapon_scene
	if weapon_scene != null:
		var weapon_instance = weapon_scene.instantiate() as Weapon
		add_child(weapon_instance)
		weapon_instance.rotation = Vector3(0, 0, 0)


func _process(delta: float) -> void:
	if on_floor:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		on_floor = true
		velocity = Vector3.ZERO

func get_used(_inv: Inventory) -> void:
	queue_free()
