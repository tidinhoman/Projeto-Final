extends Area3D

func _ready() -> void:
	$MeshInstance3D.visible = false
	$final_colisao.disabled = true
	
func _process(delta: float) -> void:
	if Globalvar.moedas_especiais >= 6:
		$MeshInstance3D.visible = true
		$final_colisao.disabled = false

func _on_area_entered(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		Globalvar.fade_out = true
		
		await get_tree().create_timer(1.5).timeout
		
		if is_inside_tree():
			get_tree().change_scene_to_file("res://Cenas/tela_venceu.tscn")
