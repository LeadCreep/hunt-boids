extends Node

@onready var raycast: RayCast3D = $"../RayCast3D"

@export var interaction_range: float = 3.0
@export var inventory: Inventory = null

func _ready() -> void:
	assert(raycast != null, "RayCast3D non trouvé")
	assert(inventory != null, "Inventory non assigné")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if (collider.has_method("get_used")):
				collider.get_used(inventory)
