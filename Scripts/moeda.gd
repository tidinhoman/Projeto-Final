extends Area3D

func _on_area_entered(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		Globalvar.total_moedas += 10
		queue_free()
