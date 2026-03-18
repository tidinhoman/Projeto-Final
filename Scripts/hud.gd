extends CanvasLayer

@export var vida_maxima: int = 6

var pause_visivel = false

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var panel: Panel = $Panel

func _ready():
	progress_bar.max_value = vida_maxima
	progress_bar.value = Globalvar.player_vida
	Globalvar.total_pontos = 0
	panel.visible = false
	pause_visivel = false

func _process(delta: float) -> void:
	$total_moedas.text = str(Globalvar.total_pontos)
	progress_bar.value = Globalvar.player_vida
	
	if Globalvar.player_morreu:
		await get_tree().create_timer(1.5).timeout
		Globalvar.fade_out = true
		
	if Input.is_action_just_pressed("esc") and not pause_visivel:
		get_tree().paused = true
		$Panel/retornar.grab_focus()
		panel.visible = true
		pause_visivel = true
	elif Input.is_action_just_pressed("esc") and pause_visivel:
		get_tree().paused = false
		panel.visible = false
		pause_visivel = false
	if not pause_visivel:
		panel.visible = false

func _on_retornar_button_down() -> void:
	get_tree().paused = false
	pause_visivel = false

func _on_voltar_menu_button_down() -> void:
	if is_inside_tree():
		get_tree().change_scene_to_file("res://Cenas/menu_inicial.tscn")
