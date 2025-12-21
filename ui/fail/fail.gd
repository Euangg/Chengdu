extends Control

func _on_button_pressed() -> void:
	Global.switch_ui(Global.UI_PLAY)

func _on_button_2_pressed() -> void:
	Global.switch_ui(Global.UI_THEME)
