extends Control
class_name UI

@onready var inventory_UI: InventoryUI = $InventoryUI

func _ready() -> void:
	pass

func get_inventory_UI() -> InventoryUI:
	return inventory_UI