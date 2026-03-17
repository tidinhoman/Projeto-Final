extends Control

func _ready() -> void:
	$Panel/novoJogo.grab_focus()

func _on_novo_jogo_button_down() -> void:
	pass

func _on_carregar_jogo_button_down() -> void:
	pass

func _on_opcoes_button_down() -> void:
	pass

func _on_sair_button_down() -> void:
	get_tree().quit()
