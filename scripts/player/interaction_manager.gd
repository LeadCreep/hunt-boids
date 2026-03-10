extends Node

@onready var raycast: RayCast3D = $"../RayCast3D"

@export var interaction_range: float = 3.0
@export var inventory: Inventory = null

func _ready() -> void:
	assert(raycast != null, "RayCast3D non trouvé")
	assert(inventory != null, "Inventory non assigné")

func _process(_delta: float) -> void:
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == null:
			inventory.ui.set_interaction_hint("")
			return
		if collider.global_position.distance_to(self.global_position) < interaction_range:
			if (collider.has_method("get_interaction_hint")):
				var hint = collider.get_interaction_hint()
				inventory.ui.set_interaction_hint(hint)
			else:
				inventory.ui.set_interaction_hint("")
	else:
		inventory.ui.set_interaction_hint("")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider.global_position.distance_to(self.global_position) < interaction_range:
				if (collider.has_method("get_used")):
					collider.get_used(inventory)
