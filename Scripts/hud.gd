extends CanvasLayer

@export var vida_maxima: int = 6

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready():
	progress_bar.max_value = vida_maxima
	progress_bar.value = Globalvar.player_vida

func _process(delta: float) -> void:
	$total_moedas.text = str(Globalvar.total_moedas)
	progress_bar.value = Globalvar.player_vida
