extends Control

func _ready() -> void:
	$jogar_novamente.grab_focus()

func _on_jogar_novamente_button_down() -> void:
	pass

func _on_voltar_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Cenas/menu_inicial.tscn")
