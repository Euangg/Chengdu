extends Node2D
const EFFECT_HIT = preload("uid://c1jgvho86hv4w")

var velocity:Vector2
func _physics_process(delta: float) -> void:
	position+=velocity*delta

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(e: Enemy) -> void:
	e.hp-=1
	if e.hp<=0:e.queue_free()
	
	var effect=EFFECT_HIT.instantiate()
	effect.position=position
	effect
	add_sibling(effect)
	queue_free()
