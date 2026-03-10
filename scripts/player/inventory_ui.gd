extends VBoxContainer
class_name InventoryUI

@onready var slot1_ui: HBoxContainer = $"InventorySlot1"
@onready var slot2_ui: HBoxContainer = $"InventorySlot2"
@onready var slot3_ui: HBoxContainer = $"InventorySlot3"
@onready var capsule_ui: HBoxContainer = $"Currency"

var slot1_text: Label = null
var slot2_text: Label = null
var slot3_text: Label = null
var capsule_text: Label = null

func _ready() -> void:
	slot1_text = slot1_ui.get_node("SlotCount") as Label
	slot2_text = slot2_ui.get_node("SlotCount") as Label
	slot3_text = slot3_ui.get_node("SlotCount") as Label
	capsule_text = capsule_ui.get_node("SlotCount") as Label

func _process(_delta: float) -> void:
	pass


func update_ui(inventory: Inventory) -> void:
	slot1_text.text = str(inventory.slot1_count)
	slot2_text.text = str(inventory.slot2_count)
	slot3_text.text = str(inventory.slot3_count)
	capsule_text.text = str(inventory.counter_capsule)