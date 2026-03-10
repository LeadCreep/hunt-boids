extends Control
class_name UI

@export var inventory_UI: InventoryUI
@onready var interaction_hint_label: Label = $"./InteractionHint"

func _ready() -> void:
	pass

func get_inventory_UI() -> InventoryUI:
	return inventory_UI

func set_interaction_hint(hint: String) -> void:
	interaction_hint_label.text = hint