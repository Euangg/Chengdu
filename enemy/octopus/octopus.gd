extends Enemy

const HAND = preload("uid://dm0eolg8iso20")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"appear":
			%AnimationPlayer.play("idle")
			%Timer.start()
		"attack":
			%AnimationPlayer.play("idle")
			%Timer.start()

func shoot():
	var l:Node2D=HAND.instantiate()
	l.position.y=position.y-500
	if randf()>0.5:
		l.scale.x=1
		l.position.x=0
	else:
		l.scale.x=-1
		l.position.x=1920
	add_sibling(l)

func _on_timer_timeout() -> void:
	%AnimationPlayer.play("attack")

func _on_area_2d_body_entered(body: Player) -> void:body.try_get_hurt(1)
