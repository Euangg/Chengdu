extends Player


var use:float
func _physics_process(delta: float) -> void:
	if  Input.is_action_just_pressed("mouse_right"):
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
				Global.play_sfx(Global.SFX_SHOTGUN)
				var tween=create_tween()
				for i in 6:
					tween.tween_property(self,"use",0,0.012)
					tween.tween_callback(shoot_ammo)
		1:
			if Input.is_action_just_pressed("mouse_left"):%SfxLaser.play()
			if Input.is_action_pressed("mouse_left"):
				velocity+=-30*vec.normalized()
				%Particles2.emitting=true
				%Laser.shoot()
				
			if Input.is_action_just_released("mouse_left"):
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
