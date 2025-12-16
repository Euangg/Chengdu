extends Control

func _ready() -> void:
	Global.play_bgm(Global.SFX_SHOOT)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_ui(Global.UI_THEME)
	
	if Input.is_action_just_pressed("mouse_left"):
		Global.play_sfx(Global.SFX_SHOOT)
