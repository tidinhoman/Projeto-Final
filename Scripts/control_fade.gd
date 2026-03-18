extends Control

@onready var anim_fade: AnimationPlayer = $fade/AnimationPlayer

func _ready() -> void:
	Globalvar.fade_out = false
	Globalvar.fade_in = true
	Fade_In()
	
func _process(delta: float) -> void:
	Fade_In()
	Fade_Out()
	
	
func Fade_In():
	if Globalvar.fade_in:
		anim_fade.play("Fade_In")
		await get_tree().create_timer(1.5).timeout
		Globalvar.fade_in = false
		
func Fade_Out():
	if Globalvar.fade_out:
		anim_fade.play("Fade_Out")
		await get_tree().create_timer(1.5).timeout
		Globalvar.fade_out = false 
