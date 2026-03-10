extends Control
class_name UI

@onready var inventory_UI: InventoryUI = $InventoryUI
@onready var interaction_hint_label: Label = $InteractionHint

func _ready() -> void:
	pass

func get_inventory_UI() -> InventoryUI:
	return inventory_UI

func set_interaction_hint(hint: String) -> void:
	interaction_hint_label.text = hint