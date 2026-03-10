extends Node3D
class_name BoidsManager

var boid_ressources: Array[BoidRessource] = [
	preload("res://custom_resources/boids/boid_normal.tres"),
	preload("res://custom_resources/boids/boid_rare.tres"),
	preload("res://custom_resources/boids/boid_legendary.tres"),
]
var boids: Array[Boid] = []
var boid_scene: PackedScene = preload("res://prefabs/boids/boid.tscn")

@export var target_number_of_boids: int = 100
@onready var spawn_box: Area3D = $"SpawnBox"

@export var neighbor_radius: float = 5.0
var timer_update_neighbors: float = 0.0
@export var update_neighbors_interval: float = 1.0

@export var chance_normal_boid: float = 0.7
@export var chance_rare_boid: float = 0.25
@export var chance_legendary_boid: float = 0.05

func _ready() -> void:
	assert(spawn_box != null, "SpawnBox Area3D non trouvée")
	var collision_shape: CollisionShape3D = spawn_box.get_node("CollisionShape3D")
	var shape: Shape3D = collision_shape.shape as Shape3D
	var half_extents: Vector3 = shape.extents

	for i in target_number_of_boids:
		var random_x = randf_range(-half_extents.x, half_extents.x)
		var random_y = randf_range(-half_extents.y, half_extents.y)
		var random_z = randf_range(-half_extents.z, half_extents.z)
		var spawn_position: Vector3 = spawn_box.global_position + Vector3(random_x, random_y, random_z)
		spawn_boid(spawn_position)
	for boid: Boid in boids:
		boid.add_steering(Wander.create(0.8))
		boid.add_steering(Alignment.create(1.0))
		boid.add_steering(Cohesion.create(1.0))
		boid.add_steering(Separation.create(1.0, 2.0))
		boid.add_steering(Containment.create(2.0, spawn_box, 2.0))
	for boid: Boid in boids:
		boid.update_neighbors()

func _process(delta: float) -> void:
	timer_update_neighbors += delta
	if timer_update_neighbors >= update_neighbors_interval:
		for boid: Boid in boids:
			boid.update_neighbors()
		timer_update_neighbors = 0.0

func spawn_boid(pos: Vector3) -> void:
	var boid_instance: Boid = boid_scene.instantiate()
	var random_index: int = random_chance_boid_spawn()
	boid_instance.load_ressource(boid_ressources[random_index])
	add_child(boid_instance)
	boid_instance.global_position = pos
	match random_index:
		0:
			boid_instance.rarity = "Common"
		1:
			boid_instance.rarity = "Rare"
		2:
			boid_instance.rarity = "Legendary"
	boids.append(boid_instance)

func random_chance_boid_spawn() -> int:
	var chance: float = randf()
	if chance < chance_normal_boid:
		return 0
	elif chance < chance_normal_boid + chance_rare_boid:
		return 1
	else:
		return 2

func clear_boids() -> void:
	for boid: Boid in boids:
		boid.queue_free()
	boids.clear()

func remove_boid(boid: Boid) -> void:
	if boid in boids:
		boids.erase(boid)
	for b: Boid in boids:
		b.update_neighbors()