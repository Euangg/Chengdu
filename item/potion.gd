extends Node2D


func _on_area_2d_body_entered(body: Player) -> void:
	if body.hp<=0:body.hp=1
	else:body.hp+=1
	queue_free()
