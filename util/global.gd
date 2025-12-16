class_name _Global
extends Node

const UI_THEME = "uid://b3awrdodyo5wi"
const UI_PLAY = "uid://dpqc7t7waexaq"
func switch_ui(ui:String):get_tree().call_deferred("change_scene_to_file",ui)

const SFX_SHOOT = "uid://djux0ieaoqfni"
const SFX = preload("uid://be3bhcwq5e2vi")
func play_sfx(sfx:String):
	var s:Sfx=SFX.instantiate()
	s.stream=load(sfx)
	%Sfx.add_child(s)

func play_bgm(bgm:String):
	%Bgm.stream=load(bgm)
	%Bgm.play()
func _on_bgm_finished() -> void:%Bgm.play()
