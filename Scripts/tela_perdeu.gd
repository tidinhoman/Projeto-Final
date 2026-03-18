extends Control

var pontos_atuais = 0

func _ready() -> void:
	$jogar_novamente.grab_focus()
	pontos_atuais = 0

func _process(delta: float) -> void:
	pontos_atuais += 1
	
	if pontos_atuais >= Globalvar.total_pontos:
		pontos_atuais = Globalvar.total_pontos
		
	$total_pontos.text = str(pontos_atuais)


func _on_jogar_novamente_button_down() -> void:
	pass

func _on_voltar_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Cenas/menu_inicial.tscn")
