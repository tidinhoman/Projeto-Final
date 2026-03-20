extends PathFollow3D

@export var velocidade = 4.0

func _physics_process(delta: float) -> void:
	progress += velocidade * delta
