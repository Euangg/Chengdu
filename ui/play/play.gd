extends Control

func _ready() -> void:
	var camera_ranges=%Level01.get_node("CameraRange").get_children()
	%Camera2D.limit_left=camera_ranges[0].position.x
	%Camera2D.limit_top=camera_ranges[0].position.y
	%Camera2D.limit_right=camera_ranges[1].position.x
	%Camera2D.limit_bottom=camera_ranges[1].position.y

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_ui(Global.UI_THEME)
