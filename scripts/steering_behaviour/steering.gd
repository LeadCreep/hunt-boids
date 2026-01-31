extends Node
class_name Steer

var parent: Boid;
@export var force: float = 1;

func _ready() -> void:
	parent = get_parent();
	assert(parent is Boid)

func steer() -> Vector3:
	return Vector3.ZERO;