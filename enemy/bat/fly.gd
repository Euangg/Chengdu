extends Enemy

var diff:Vector2=Vector2(100,0)
var center:Vector2=Vector2(100,0)
var radius:float=100.0
var angular_speed:float=PI

func _ready() -> void:
	center=position+diff

func _physics_process(delta: float) -> void:
	var dir_to_obj=(position-center).normalized()
	var tangent_dir=dir_to_obj.rotated(PI/2.0)
	var linear_speed=angular_speed*radius
	velocity=tangent_dir*linear_speed
	move_and_slide()

func _on_area_2d_body_entered(p: Player) -> void:p.try_get_hurt(1)
