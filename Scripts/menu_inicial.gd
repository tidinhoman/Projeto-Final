extends Control

func _ready() -> void:
	$Panel/novoJogo.grab_focus()
	get_tree().paused = false

func _on_novo_jogo_button_down() -> void:
	Globalvar.fade_out = true
	await get_tree().create_timer(2.0).timeout
	if is_inside_tree():
		get_tree().change_scene_to_file("res://Cenas/fase.tscn")

func _on_carregar_jogo_button_down() -> void:
	pass

func _on_opcoes_button_down() -> void:
	if is_inside_tree():
		get_tree().change_scene_to_file("res://Cenas/tela_opcoes.tscn")
	pass

func _on_sair_button_down() -> void:
	get_tree().quit()
