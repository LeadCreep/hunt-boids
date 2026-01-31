extends Steer
class_name Containment

@export var area: Area3D
@export var margin: float = 2.0

func _ready() -> void:
    super._ready()

func steer() -> Vector3:
    if not area:
        return Vector3.ZERO
    
    var shape: CollisionShape3D = area.get_node("CollisionShape3D") as CollisionShape3D
    if not shape or not shape.shape is BoxShape3D:
        return Vector3.ZERO
    
    var box_size: Vector3 = shape.shape.size / 2.0
    var local_pos: Vector3 = area.to_local(parent.global_position)

    if abs(local_pos.x) < (box_size.x - margin) and \
       abs(local_pos.y) < (box_size.y - margin) and \
       abs(local_pos.z) < (box_size.z - margin):
        return Vector3.ZERO

    var target_global = area.global_position

    return (target_global - parent.global_position).normalized() * parent.MAX_SPEED

static func create(_force: float, _area: Area3D, _margin: float = 2.0) -> Containment:
    var c: Containment = Containment.new()
    c.area = _area
    c.margin = _margin
    c.force = _force
    return c