extends Control

func _ready() -> void:Global.play_bgm(Global.BGM_THEME)

func _on_button_pressed() -> void:
	Global.num_players=1
	Global.switch_ui(Global.UI_PLAY)

func _on_button_2_pressed() -> void:
	Global.num_players=2
	Global.switch_ui(Global.UI_PLAY)

func _on_button_3_pressed() -> void:
	get_tree().quit()
