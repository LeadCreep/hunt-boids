extends Resource
class_name BoidRessource

@export var max_speed: float = 5.0
@export var acceleration: float = 1.0
@export var model: PackedScene

func _init(_max_speed: float = 5.0, _acceleration: float = 1.0, _model: PackedScene = null) -> void:
	max_speed = _max_speed
	acceleration = _acceleration
	model = _model