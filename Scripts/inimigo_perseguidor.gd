extends CharacterBody3D

@export var vida = 4
@export var velocidade = 4.0
@export var distancia_parar = 1.0

var player = null

var tomou_dano = false
var atacando = false

func _ready() -> void:
	player = get_tree().current_scene.get_node("Player")
	tomou_dano = false
	atacando = false
	
func _physics_process(delta: float) -> void:
	if not player:
		return
	var distancia = global_position.distance_to(player.global_position)
	
	if distancia > distancia_parar and not tomou_dano and not atacando:
		$AnimationPlayer.play("andando")
		mover_para_player(delta)
	else:
		velocity = Vector3.ZERO
		
	olhar_para_player()
	
	move_and_slide()
	
func mover_para_player(delta):
	var direcao = (player.global_position - global_position).normalized()
	direcao.y = 0
	velocity = direcao * velocidade
	
func olhar_para_player():
	if player:
		var olhar_direcao = player.global_position - global_position
		olhar_direcao.y = 0
		if olhar_direcao != Vector3.ZERO:
			var target_rotation = atan2(-olhar_direcao.x, -olhar_direcao.z)
			rotation.y = target_rotation

func _on_inimigo_3_hurtbox_area_entered(area: Area3D) -> void:
	if area.name == "player_hitbox":
		tomou_dano = true
		vida -= Globalvar.player_dano
		$AnimationPlayer.play("tomando_dano")
		
	if vida <= 0:
		Globalvar.total_pontos += 20
		queue_free()

func _on_inimigo_3_hurtbox_area_exited(area: Area3D) -> void:
	if area.name == "player_hitbox":
		tomou_dano = false
		$AnimationPlayer.play("tomando_dano")

func _on_inimigo_3_hitbox_area_entered(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		atacando = true
		$AnimationPlayer.play("batendo")

func _on_inimigo_3_hitbox_area_exited(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		atacando = false
