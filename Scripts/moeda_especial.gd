extends Area3D

func _on_area_entered(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		Globalvar.moedaes_coletada = true
		Globalvar.moedas_especiais += 1
		queue_free()
