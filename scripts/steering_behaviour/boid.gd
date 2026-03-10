extends CharacterBody3D
class_name Boid

@export var MAX_SPEED = 5.0
@export var ACCELERATION = 1.0

var steerings: Array[Steer]
var desired_velocity: Vector3 = Vector3.ZERO
var steering_force: Vector3 = Vector3.ZERO
var drone: Drone

var dead_boid: PackedScene = preload("res://prefabs/boids/deadBoid.tscn")
var drone_packed: PackedScene = preload("res://prefabs/boids/drone.tscn")

var rarity: String = "Common"

func _ready() -> void:
	for s in get_children():
		if (s is Steer):
			steerings.append(s)
	velocity = - transform.basis.z * MAX_SPEED

func _physics_process(delta: float) -> void:
	desired_velocity = Vector3.ZERO;
	for s: Steer in steerings:
		desired_velocity += s.steer() * s.force
	
	if desired_velocity.length() > 0:
		steering_force = (desired_velocity - velocity) * (ACCELERATION * delta);
		velocity += steering_force
	
	if (velocity.length() > MAX_SPEED):
		velocity = velocity.normalized() * MAX_SPEED
	
	if velocity.length() > 0.1:
		look_at(global_position + velocity, Vector3.UP)
	
	move_and_slide()

func add_steering(behaviour: Steer) -> void:
	add_child(behaviour)
	steerings.append(behaviour)

func remove_steering(behaviour: Steer) -> void:
	if behaviour in steerings:
		steerings.erase(behaviour)
		behaviour.queue_free()

func get_neighbors() -> Array[Boid]:
	var neighbors: Array[Boid] = []
	var boids_manager: BoidsManager = get_parent()
	assert(boids_manager is BoidsManager)
	for boid: Boid in boids_manager.boids:
		if boid != self:
			var distance = (boid.global_position - global_position).length()
			if distance < boids_manager.neighbor_radius:
				neighbors.append(boid)
	return neighbors

func update_neighbors() -> void:
	for s: Steer in steerings:
		if s.has_method("update_neighbors"):
			s.update_neighbors()

func get_hit() -> void:
	var parent = get_parent() as BoidsManager
	parent.remove_boid(self )
	var dead_boid_instance: Node3D = dead_boid.instantiate()
	parent.add_child(dead_boid_instance)
	dead_boid_instance.global_transform = global_transform
	dead_boid_instance.velocity = velocity
	dead_boid_instance.drone.set_color(drone.rarity_torus_1.material_override.albedo_color)
	dead_boid_instance.rarity = rarity
	queue_free()

func load_ressource(ressource: BoidRessource) -> void:
	drone = drone_packed.instantiate() as Drone
	drone.position = Vector3.ZERO
	add_child(drone)
	MAX_SPEED = ressource.max_speed
	ACCELERATION = ressource.acceleration
	drone.set_color(ressource.color)
