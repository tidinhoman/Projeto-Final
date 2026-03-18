extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		if is_inside_tree():
			get_tree().change_scene_to_file("res://Cenas/menu_inicial.tscn")
