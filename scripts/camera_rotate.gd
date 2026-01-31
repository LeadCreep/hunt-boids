extends Node3D

@export var rotation_point: Node3D;

func _process(delta: float) -> void:
	rotation.y += 0.5*delta;
