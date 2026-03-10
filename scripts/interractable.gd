extends CharacterBody3D
class_name Interractable

@export var interraction_hint = "[E] Interact"

func get_interaction_hint() -> String:
	return interraction_hint


func get_used(_inv: Inventory) -> void:
	pass