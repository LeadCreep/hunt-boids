extends Node
class_name Inventory

@export var ui: UI
@export var player: Player
var inventory_ui: InventoryUI = null

var slot1_count: int = 0
var slot2_count: int = 0
var slot3_count: int = 0
var counter_capsule: int = 0

func _ready() -> void:
	inventory_ui = ui.get_inventory_UI()
	if inventory_ui == null:
		print("Error: InventoryUI not found in UI")

func add_weapon(weapon_scene: PackedScene) -> void:
	$"../../WeaponManager".switch_weapon(weapon_scene)

func add_boid(boid_type: String) -> void:
	match boid_type:
		"Common":
			slot1_count += 1
		"Rare":
			slot2_count += 1
		"Legendary":
			slot3_count += 1
	inventory_ui.update_ui(self as Inventory)


func add_capsule(count: int) -> void:
	counter_capsule += count
	player.add_score(count)
	inventory_ui.update_ui(self as Inventory)
