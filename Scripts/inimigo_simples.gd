extends PathFollow3D

@export var vida = 5.0
@export var velocidade = 5.0

var atacando = false
var tomou_dano = false

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	vida = 5
	atacando = false

func _process(delta: float) -> void:
	progress += velocidade * delta
	
	if progress >= 0 and not atacando and not tomou_dano:
		anim.play("andando")
		
func _on_hitbox_area_entered(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		atacando = true
		anim.play("atacando")

func _on_hitbox_area_exited(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		atacando = false

func _on_inimigo_1_hurtbox_area_entered(area: Area3D) -> void:
	if area.name == "player_hitbox":
		tomou_dano = true
		anim.play("levando_dano")
		vida -= Globalvar.player_dano
		
	if vida <= 0:
		queue_free()

func _on_inimigo_1_hurtbox_area_exited(area: Area3D) -> void:
	if area.name == "player_hitbox":
		tomou_dano = false
