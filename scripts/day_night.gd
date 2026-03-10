extends Node

@export var sunlight: DirectionalLight3D
@export var world_environment: WorldEnvironment
@export var day_duration: float = 20.0

@export var time_of_day: float = 0.0

@export var end_screen_scene: PackedScene

var stopped: bool = false


func _ready() -> void:
	sunlight.rotation_degrees.x = time_of_day * 360.0
	

func _process(delta: float) -> void:
	if stopped:
		return

	time_of_day += (delta / day_duration)

	if time_of_day >= 0.75:
		var end_screen = end_screen_scene.instantiate() as Control
		end_screen.set_score($"../../Player".score)
		get_tree().root.add_child(end_screen)
		$"../../Player".queue_free()
		stopped = true

	sunlight.rotation_degrees.x = time_of_day * 360.0
	_update_environment()


func _update_environment() -> void:
	var deg_x: float = sunlight.rotation_degrees.x

	if is_daytime(deg_x):
		var intensity = _sun_intensity(deg_x)
		sunlight.light_energy = intensity
	else:
		sunlight.light_energy = 0.0

func is_daytime(deg_x: float) -> bool:
	return deg_x > 90.0 and deg_x < 270.0

func is_nighttime(deg_x: float) -> bool:
	return not is_daytime(deg_x)

func _sun_intensity(deg_x: float) -> float:
	var normalized = (deg_x - 90.0) / 180.0
	return sin(normalized * PI)

func get_clock_time() -> String:
	var total_minutes: int = int(time_of_day * 24.0 * 60.0)
	var hours: int = int(float(total_minutes) / 60.0)
	var minutes: int = total_minutes % 60
	return "%02d:%02d : %.2f" % [hours, minutes, time_of_day]
