extends PathFollow3D

@export var velocidade = 6.0

func _process(delta: float) -> void:
	progress += velocidade * delta
