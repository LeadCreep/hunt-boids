extends Steer
class_name Seek

@export var target: Node3D;

func _ready() -> void:
	super._ready()
	assert(target != null, "Target non définie pour Seek")

func steer() -> Vector3:
	return (target.global_position - parent.global_position).normalized() * parent.MAX_SPEED;

static func create(_force: float, _target: Node3D) -> Seek:
	var s: Seek = Seek.new()
	s.target = _target
	s.force = _force
	return s