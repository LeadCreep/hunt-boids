extends CharacterBody3D
class_name Interractable

@export var interraction_hint = "[E] Interact"
@export var price: int = 0


func get_interaction_hint() -> String:
	if price > 0:
		return interraction_hint + " (" + str(price) + " capsules)"
	return interraction_hint


func get_used(_inv: Inventory) -> void:
	pass