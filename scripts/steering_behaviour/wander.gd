extends Steer
class_name Wander

@export var look_ahead: float = 10.0
@export var wander_radius: float = 3.0
@export var jitter: float = 0.1

var wander_target: Vector3 = Vector3.ZERO

func _ready() -> void:
	super._ready()
	wander_target = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized() * wander_radius

func steer() -> Vector3:
	var displacement = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)) * jitter
	wander_target += displacement
	
	wander_target = wander_target.normalized() * wander_radius
	
	var forward = - parent.global_transform.basis.z.normalized()
	var circle_center = parent.global_position + forward * look_ahead
	
	var final_target = circle_center + wander_target
	
	return (final_target - parent.global_position).normalized() * parent.MAX_SPEED

static func create(_force: float, _look_ahead: float = 10.0, _wander_radius: float = 3.0, _jitter: float = 0.1) -> Wander:
	var w: Wander = Wander.new()
	w.look_ahead = _look_ahead
	w.wander_radius = _wander_radius
	w.jitter = _jitter
	w.force = _force
	return w