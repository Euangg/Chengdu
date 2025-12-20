extends CharacterBody2D
const LASER = preload("uid://bbr5i1oprwca")


func _physics_process(delta: float) -> void:
	if %AnimationPlayer.current_animation=="pre":pass
	else:
		if %RayCast2D.is_colliding():%AnimationPlayer.play("pre")

func shoot():
	var l:Node2D=LASER.instantiate()
	l.scale.x=%Graphic.scale.x
	l.global_position=global_position
	add_sibling(l)

func shoot_end():
	%AnimationPlayer.play("RESET")
