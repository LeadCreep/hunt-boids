extends Steer
class_name Separation

@export var desired_separation: float = 2.0

var neighbors: Array[Boid] = []

func _ready() -> void:
	super._ready()
	update_neighbors()

func steer() -> Vector3:
	var separation_force = Vector3.ZERO
	
	for neighbor in neighbors:
		var to_agent = parent.global_position - neighbor.global_position
		var distance = to_agent.length()
		if distance > 0 and distance < desired_separation:
			separation_force += to_agent.normalized() / distance
	
	if neighbors.size() > 0:
		separation_force /= float(neighbors.size())
	
	return separation_force.normalized() * parent.MAX_SPEED if separation_force != Vector3.ZERO else Vector3.ZERO;


func update_neighbors() -> void:
	neighbors = parent.get_neighbors()

static func create(_force: float, _desired_separation: float = 2.0) -> Separation:
	var s: Separation = Separation.new()
	s.desired_separation = _desired_separation
	s.force = _force
	return s
