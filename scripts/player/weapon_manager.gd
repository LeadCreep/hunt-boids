extends Node3D

@onready var raycast: RayCast3D = $"../RayCast3D"
@onready var weapon_mesh: MeshInstance3D = $"WeaponPoint/WeaponMesh"
@onready var weapon_animation: AnimationPlayer = $"WeaponAnimation"

@export var raycast_length: float = 1000.0

func _ready() -> void:
	raycast.target_position = Vector3(0, 0, -raycast_length)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		weapon_animation.stop()
		weapon_animation.play("fire")
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider.has_method("get_hit"):
				collider.get_hit()

func _process(_delta: float) -> void:
	pass
