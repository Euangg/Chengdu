extends Enemy

const BIG_LASER = preload("uid://c7yf5k4hsw43i")

func _physics_process(delta: float) -> void:
	pass

func sound():Global.play_sfx(Global.SFX_BIG_LASER)

func shoot():
	var l:Node2D=BIG_LASER.instantiate()
	l.global_position=%Marker2D.global_position
	add_sibling(l)

func _on_timer_timeout() -> void:
	%AnimationPlayer.play("pre_attack")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"pre_attack":%AnimationPlayer.play("attack")
		"attack":
			%AnimationPlayer.play("idle")
			%Timer.start()

func _on_area_2d_body_entered(body: Player) -> void:body.try_get_hurt(1)
