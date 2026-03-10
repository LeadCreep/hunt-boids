extends Node3D
class_name Drone

@export var rarity_torus_1: MeshInstance3D
@export var rarity_torus_2: MeshInstance3D

var color: Color = Color(1, 1, 1)

func update_color() -> void:
	rarity_torus_1.material_override.albedo_color = color
	rarity_torus_2.material_override.albedo_color = color
	rarity_torus_1.material_override.emission = color
	rarity_torus_2.material_override.emission = color

func set_color(_color: Color) -> void:
	color = _color
	update_color()