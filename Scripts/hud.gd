extends CanvasLayer

@export var vida_maxima: int = 6

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready():
	progress_bar.max_value = vida_maxima
	progress_bar.value = Globalvar.player_vida
	Globalvar.total_pontos = 0

func _process(delta: float) -> void:
	$total_moedas.text = str(Globalvar.total_pontos)
	progress_bar.value = Globalvar.player_vida
	
	if Globalvar.player_morreu:
		await get_tree().create_timer(1.5).timeout
		Globalvar.fade_out = true
