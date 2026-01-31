extends Steer
class_name Cohesion

var neighbors: Array[Boid] = []

func _ready() -> void:
	super._ready()
	update_neighbors()

func steer() -> Vector3:
	var cohesion_force = Vector3.ZERO
	
	for neighbor in neighbors:
		cohesion_force += neighbor.global_position
	
	if neighbors.size() > 0:
		cohesion_force /= float(neighbors.size())
		cohesion_force = (cohesion_force - parent.global_position).normalized() * parent.MAX_SPEED
	
	return cohesion_force;

func update_neighbors() -> void:
	neighbors = parent.get_neighbors()

static func create(_force: float) -> Cohesion:
	var c: Cohesion = Cohesion.new()
	c.force = _force
	return c