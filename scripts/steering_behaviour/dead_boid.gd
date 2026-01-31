extends CharacterBody3D

var on_floor: bool = false

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
