extends PathFollow3D

@export var velocidade = 5.0

var atacando = false

@onready var anim: AnimationPlayer = $Armature/AnimationPlayer

func _ready() -> void:
	atacando = false

func _process(delta: float) -> void:
	progress += velocidade * delta
	
	if progress >= 0 and not atacando:
		anim.play("Walk")
		
func _on_hitbox_area_entered(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		atacando = true
		anim.play("Attack")

func _on_hitbox_area_exited(area: Area3D) -> void:
	if area.name == "player_hurtbox":
		atacando = false
