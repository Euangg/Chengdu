extends Node2D

@onready var area_2d: Area2D = %Area2D

func _physics_process(delta: float) -> void:
	if area_2d.monitoring:
		for e:Enemy in area_2d.get_overlapping_bodies():
			e.hp-=10*delta
			if e.hp<=0:e.queue_free()

func shoot():
	visible=true
	%Area2D.monitoring=true
	
func stop():
	visible=false
	%Area2D.monitoring=false
	
