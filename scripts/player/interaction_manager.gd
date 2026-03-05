extends Node

@onready var raycast: RayCast3D = $"../RayCast3D"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			print("Use")
			if (collider.has_method("get_used")):
				collider.get_used()
