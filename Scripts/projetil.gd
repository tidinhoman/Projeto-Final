extends Area3D

@export var velocidade = 15.0
@export var tempo_vida = 3.0

var direcao: Vector3 = Vector3.FORWARD

func _ready() -> void:
	await get_tree().create_timer(tempo_vida).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	global_position += direcao * velocidade * delta
	
