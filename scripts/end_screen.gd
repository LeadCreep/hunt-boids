extends Control

@export var score_label: Label

func set_score(score: int) -> void:
	score_label.text = str(score)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()
	if event.is_action_pressed("retry"):
		get_tree().reload_current_scene()
		queue_free()
