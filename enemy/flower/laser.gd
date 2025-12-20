extends Node2D

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Player) -> void:body.try_get_hurt(1)
