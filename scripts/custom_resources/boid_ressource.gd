extends Resource
class_name BoidRessource

@export var max_speed: float = 5.0
@export var acceleration: float = 1.0
@export var color: Color = Color(1, 1, 1)

func _init(_max_speed: float = 5.0, _acceleration: float = 1.0, _color: Color = Color(1, 1, 1)) -> void:
	max_speed = _max_speed
	acceleration = _acceleration
	color = _color
