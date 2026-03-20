extends CharacterBody3D

@export var vida = 3
@export var velocidade = 2.0
@export var distancia_parar = 10.0
@export var tempo_entre_tiros = 2.0
@export var projetil_scene: PackedScene = preload("res://Cenas/projetil.tscn")

var player = null
var pode_atirar = true

@onready var arma_ponto: Marker3D = $ponto_tiro

func _ready():
	player = get_tree().current_scene.get_node("Player")
	
func _physics_process(delta):
	if player == null:
		return
	
	var distancia = global_position.distance_to(player.global_position)
	
	if distancia < distancia_parar:
		atirar_no_player()
	
	move_and_slide()

func atirar_no_player():
	if not pode_atirar or player == null:
		return
	
	pode_atirar = false
	
	if projetil_scene == null:
		pode_atirar = true
		return
	
	var projetil = projetil_scene.instantiate()
	
	get_tree().current_scene.add_child(projetil)
	
	projetil.global_position = arma_ponto.global_position
	
	var direcao_tiro = (player.global_position - arma_ponto.global_position).normalized()
	
	if projetil.has_method("set_direcao"):
		projetil.set_direcao(direcao_tiro)
	else:
		projetil.direcao = direcao_tiro
	
	await get_tree().create_timer(tempo_entre_tiros).timeout
	pode_atirar = true

func _on_inimigo_2_hurtbox_area_entered(area: Area3D) -> void:
	if area.name == "player_hitbox":
		vida -= Globalvar.player_dano
		$AnimationPlayer.play("tomando_dano")
		
	if vida <= 0:
		queue_free()

func _on_inimigo_2_hurtbox_area_exited(area: Area3D) -> void:
	if area.name == "player_hitbox":
		$AnimationPlayer.play("levantando")
