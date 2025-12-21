class_name Player
extends CharacterBody2D

const AMMO = preload("uid://c1cvvtsekr5he")
enum State{
	IDLE,
	RISE,
	FALL
}
var state:State=State.IDLE
var angle:float

var hp:int=10
var weapon:int=0

func shoot_ammo():
	var a=AMMO.instantiate()
	var new_vec=Vector2.from_angle(angle+randf_range(-0.05,0.05))
	a.velocity=new_vec.normalized()*2000
	a.global_position=%Hand.global_position
	a.rotation=new_vec.angle()
	Global.node_element.add_child(a)

func try_get_hurt(hurt_amount:int):
	if %TimerInvincible.is_stopped():
		hp-=hurt_amount
		%TimerInvincible.start()
		modulate.a=0.5
		print(hp)
	else:pass
