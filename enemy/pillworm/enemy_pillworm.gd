extends Enemy

func _ready() -> void:
	velocity.x=100

func _physics_process(delta: float) -> void:
	velocity.y+=800*delta
	move_and_slide()
	
	if %RayCast2D.is_colliding():pass
	else:
		velocity.x*=-1
		%Graphic.scale.x*=-1
		return
	
	if %RayCast2D2.is_colliding():
		velocity.x*=-1
		%Graphic.scale.x*=-1

func _on_area_2d_body_entered(body: Player) -> void:body.try_get_hurt(1)
