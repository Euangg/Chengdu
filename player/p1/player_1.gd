extends Player


var is_shoot_input
var is_shooting
var use:float
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		if %TimerCd.time_left<0.1:is_shoot_input=true
		is_shooting=true
	
	if Input.is_action_just_released("mouse_left"):is_shooting=false
		
	
	if  Input.is_action_just_pressed("mouse_right"):
		is_shoot_input=false
		is_shooting=false
		%Particles2.emitting=false
		%Laser.stop()
		%SfxLaser.stop()
		match weapon:
			0:weapon=1
			1:weapon=0
	
	var vec=get_global_mouse_position()-position
	%Hand.rotation=vec.angle()
	angle=vec.angle()
	
	match weapon:
		0:
			if is_shoot_input and %TimerCd.is_stopped():
				is_shoot_input=false
				if amount_ammo>=2:
					amount_ammo-=2
					%TimerCd.start()
					velocity+=-500*vec.normalized()
					%Particles1.restart()
					Global.play_sfx(Global.SFX_SHOTGUN)
					var tween=create_tween()
					for i in 6:
						tween.tween_property(self,"use",0,0.012)
						tween.tween_callback(shoot_ammo)
		1:
			if is_shooting:
				if amount_ammo>5*delta:
					amount_ammo-=5*delta
					%Particles2.emitting=true
					%Laser.shoot()
					if %SfxLaser.playing:pass
					else:%SfxLaser.play()
					velocity+=-40*vec.normalized()
				else:
					%Particles2.emitting=false
					%Laser.stop()
					%SfxLaser.stop()
			else:
				%Particles2.emitting=false
				%Laser.stop()
				%SfxLaser.stop()
	
	velocity.x=move_toward(velocity.x,0.0,600*delta)
	velocity.y=move_toward(velocity.y,0.0,600*delta)
	velocity.y+=800*delta
	var is_on_floor_before:bool=is_on_floor()
	move_and_slide()
	if is_on_floor_before!=is_on_floor():
		%ParticlesLand.restart()
	
	if is_on_floor():amount_ammo+=5*delta
	else :amount_ammo+=1*delta
	amount_ammo=min(amount_ammo,amount_ammo_max)
	%TextureProgressBar.max_value=amount_ammo_max
	%TextureProgressBar.value=amount_ammo
	
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

func _on_timer_invincible_timeout() -> void:
	modulate.a=1


func _on_sfx_laser_finished() -> void:%SfxLaser.play()
