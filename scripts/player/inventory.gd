extends Node
class_name Inventory

@export var ui: UI
var inventory_ui: InventoryUI = null

func _ready() -> void:
	inventory_ui = ui.get_inventory_UI()