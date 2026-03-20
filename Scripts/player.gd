extends CharacterBody3D

@export var velocidade = 10.0
@export var velocidade_pulo = 5.0

var andando = false
var esta_pulando = false
var esta_atacando = false
var tomou_dano = false
var morte_processada = false

var respawn

@onready var anim: AnimationPlayer = $Armature/Skeleton3D/AnimationPlayer
@onready var hitbox: CollisionShape3D = $player_hitbox/colisao_hitbox

func _ready() -> void:
	esta_atacando = false
	hitbox.disabled = true
	tomou_dano = false
	Globalvar.player_morreu = false
	morte_processada = false
	Globalvar.player_vida = 6

	respawn = get_parent().get_node("Checkpoint")

func _physics_process(delta: float) -> void:
	if Globalvar.player_morreu:
		animacao()
		morte()
		return
	
	movimentacao(delta)
	ataque()
	animacao()
	
	if Globalvar.player_vida <= 0 and not Globalvar.player_morreu:
		morte()

func movimentacao(delta: float):
	if esta_atacando or Globalvar.player_morreu:
		return
		
	if not is_on_floor():
		esta_pulando = true
		velocity += get_gravity() * delta
	else:
		esta_pulando = false

	if Input.is_action_just_pressed("pulo") and is_on_floor():
		esta_pulando = true
		velocity.y = velocidade_pulo

	var input_dir := Input.get_vector("direita", "esquerda", "tras", "frente")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * velocidade
		velocity.z = direction.z * velocidade
		andando = true
		
		rotacionar(direction, delta)
		
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
		velocity.z = move_toward(velocity.z, 0, velocidade)
		andando = false

	move_and_slide()

func rotacionar(direction: Vector3, delta: float):
	var posicao_alvo = global_position - direction
	
	$Armature.look_at(posicao_alvo, Vector3.UP)
	$player_hitbox.look_at(posicao_alvo, Vector3.UP)

func ataque():
	if esta_pulando or esta_atacando or Globalvar.player_morreu:
		return

	if Input.is_action_just_pressed("ataque"):
		andando = false
		esta_atacando = true
		anim.play("Attack")
		hitbox.disabled = false
		await get_tree().create_timer(0.8).timeout
		hitbox.disabled = true
		esta_atacando = false
		andando = true

func animacao():
	if Globalvar.player_morreu or tomou_dano:
		return
	
	if esta_pulando:
		anim.play("Jump")
	elif andando:
		anim.play("Run")
	elif esta_atacando:
		anim.play("Attack")
	else:
		anim.play("Idle")

func _on_player_hurtbox_area_entered(area: Area3D) -> void:
	if area.name == "inimigo1_hitbox" or area.name == "projetil" or area.name == "inimigo3_hitbox":
		tomou_dano = true
		Globalvar.total_pontos -= 5
		Globalvar.player_vida -= 1
		anim.play("Hurt")
		
		if Globalvar.player_vida <= 0:
			morte()
		else:
			await get_tree().create_timer(0.8).timeout
			tomou_dano = false
	
	if area.name == "buraco":
		Globalvar.player_vida -= 1
		Globalvar.total_pontos -= 5
		Globalvar.fade_out = true
		await get_tree().create_timer(1.5).timeout
		Globalvar.fade_out = false
		Globalvar.fade_in = true
		position = respawn.global_position
		
func morte():
	if morte_processada:
		return
		
	morte_processada = true
	Globalvar.player_morreu = true
	
	esta_atacando = false
	hitbox.disabled = true
	velocity = Vector3.ZERO
	
	anim.play("Death")
	
	await get_tree().create_timer(3.5).timeout
	
	if is_inside_tree():
		get_tree().change_scene_to_file("res://Cenas/tela_perdeu.tscn")
