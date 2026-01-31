extends Steer
class_name Alignment

var neighbors: Array[Boid] = []

func _ready() -> void:
	super._ready()
	update_neighbors()

func steer() -> Vector3:
	var alignment_force = Vector3.ZERO
	
	for neighbor in neighbors:
		alignment_force += neighbor.velocity
	
	if neighbors.size() > 0:
		alignment_force /= float(neighbors.size())
		alignment_force = alignment_force.normalized() * parent.MAX_SPEED
	
	return alignment_force;

func update_neighbors() -> void:
	neighbors = parent.get_neighbors()

static func create(_force: float) -> Alignment:
	var a: Alignment = Alignment.new()
	a.force = _force
	return a
