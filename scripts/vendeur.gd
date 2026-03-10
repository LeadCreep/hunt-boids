extends Interractable

func get_used(_inv: Inventory) -> void:
	var count_common = _inv.slot1_count
	var count_rare = _inv.slot2_count
	var count_legendary = _inv.slot3_count
	var total = count_common * 10 + count_rare * 20 + count_legendary * 50
	_inv.slot1_count = 0
	_inv.slot2_count = 0
	_inv.slot3_count = 0
	_inv.add_capsule(total)