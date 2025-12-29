class_name _Global
extends Node

const UI_THEME = "uid://b3awrdodyo5wi"
const UI_PLAY = "uid://dpqc7t7waexaq"
const UI_WIN = ("uid://cr0nbotihgd41")
const UI_FAIL = ("uid://btygn1a8iobxj")
func switch_ui(ui:String):get_tree().call_deferred("change_scene_to_file",ui)
const SFX_BIG_LASER = "uid://c4muf1td5fpja"
const SFX_SHOTGUN = "uid://d37rs7ktkpwt"
const SFX = preload("uid://be3bhcwq5e2vi")
func play_sfx(sfx:String):
	var s:Sfx=SFX.instantiate()
	s.stream=load(sfx)
	%Sfx.add_child(s)

const BGM_THEME = "uid://dhe4cj7u51448"
func play_bgm(bgm:String):
	%Bgm.stream=load(bgm)
	%Bgm.play()
func _on_bgm_finished() -> void:%Bgm.play()

var num_players:int=1
var node_element:Node=null
var camera:Camera2D=null
