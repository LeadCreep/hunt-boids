extends Resource
class_name BoidRessource

@export var max_speed: float = 5.0
@export var acceleration: float = 1.0
@export var mesh: Mesh
@export var material: Material

func _init(_max_speed: float = 5.0, _acceleration: float = 1.0, _mesh: Mesh = null, _material: Material = null) -> void:
	max_speed = _max_speed
	acceleration = _acceleration
	mesh = _mesh
	material = _material