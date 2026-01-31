extends Steer
class_name Flee

@export var target: Node3D;

func _ready() -> void:
	super._ready()
	assert(target != null, "Target non définie pour Flee")

func steer() -> Vector3:
	return (parent.global_position - target.global_position).normalized() * parent.MAX_SPEED;

static func create(_force: float, _target: Node3D) -> Flee:
	var f: Flee = Flee.new()
	f.target = _target
	f.force = _force
	return f