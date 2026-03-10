extends Interractable

var on_floor: bool = false

var drone_packed: PackedScene = preload("res://prefabs/boids/drone.tscn")
var drone: Drone

func _init() -> void:
	drone = drone_packed.instantiate() as Drone
	add_child(drone)

func _physics_process(delta: float) -> void:
	if on_floor:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if velocity.length() > 0.1:
		look_at(global_position + velocity, Vector3.UP)

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		on_floor = true
		velocity = Vector3.ZERO

func get_used(_inv: Inventory) -> void:
	queue_free()
