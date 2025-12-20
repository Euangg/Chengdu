class_name Player
extends CharacterBody2D
const AMMO = preload("uid://c1cvvtsekr5he")

enum State{
	IDLE,
	RISE,
	FALL
}
var state:State=State.IDLE

var hp:int=3
var weapon:int=0
var angle:float
var use:float
func _physics_process(delta: float) -> void:
	var is_space_pressed= Input.is_action_just_pressed("space")
	if is_space_pressed:
		match weapon:
			0:weapon=1
			1:weapon=0
	
	var vec=get_global_mouse_position()-position
	%Hand.rotation=vec.angle()
	angle=vec.angle()
	
	match weapon:
		0:
			if Input.is_action_just_pressed("mouse_left"):
				velocity+=-500*vec.normalized()
				%Particles1.restart()
				Global.play_sfx(Global.SFX_SHOOT)
				var tween=create_tween()
				for i in 6:
					tween.tween_property(self,"use",0,0.012)
					tween.tween_callback(shoot_ammo)
		1:
			if Input.is_action_pressed("mouse_left"):
				velocity+=-30*vec.normalized()
				%Particles2.emitting=true
				%Laser.shoot()
			if Input.is_action_just_released("mouse_left"):
				%Particles2.emitting=false
				%Laser.stop()
	
	velocity.x=move_toward(velocity.x,0.0,600*delta)
	velocity.y=move_toward(velocity.y,0.0,600*delta)
	velocity.y+=800*delta
	var is_on_floor_before:bool=is_on_floor()
	move_and_slide()
	if is_on_floor_before!=is_on_floor():
		%ParticlesLand.restart()
	
	#1/3.状态判断
	var nextState=state
	match state:
		State.IDLE:
			if velocity.y>0:nextState=State.FALL
			if velocity.y<0:nextState=State.RISE
		State.RISE:
			if velocity.y>0:nextState=State.FALL
		State.FALL:
			if velocity.y<0:nextState=State.RISE
			if is_on_floor():nextState=State.IDLE
	#2/3.状态切换
	if nextState==state:pass
	else:
		match nextState:
			State.IDLE:%AnimationPlayer.play("idle")
			State.RISE:%AnimationPlayer.play("rise")
			State.FALL:%AnimationPlayer.play("fall")
		state=nextState
	#3/3.状态运行
	match state:
		State.IDLE:pass
		State.RISE:pass
		State.FALL:pass

func try_get_hurt(hurt_amount:int):
	if %TimerInvincible.is_stopped():
		hp-=hurt_amount
		%TimerInvincible.start()
		modulate.a=0.5
		print(hp)
	else:pass

func _on_timer_invincible_timeout() -> void:
	modulate.a=1

func shoot_ammo():
	var a=AMMO.instantiate()
	var new_vec=Vector2.from_angle(angle+randf_range(-0.05,0.05))
	a.velocity=new_vec.normalized()*2000
	a.global_position=%Hand.global_position
	a.rotation=new_vec.angle()
	add_sibling(a)
