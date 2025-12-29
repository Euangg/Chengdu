extends Control
const PLAYER_2 = preload("uid://dolwekail5gsj")
const ENEMY_DRAGON = preload("uid://7x2r2f065fvs")
const ENEMY_OCTOPUS = preload("uid://dbi7lwvxylslm")
const HEART_1 = preload("uid://bpb6k63siyqkv")
const HEART_2 = preload("uid://d0e1ty5c5gk3c")

@onready var node_players: Node = $NodePlayers
var player_1:Player=null
var player_2:Player=null
var enemy_dragon: Enemy=null
var enemy_octopus:Enemy=null
var boss_dragon_summoned=false
var boss_octopus_summoned=false
func _ready() -> void:
	Global.node_element=%NodeElements
	
	player_1=%Player
	if Global.num_players==2:
		var p2:Player=PLAYER_2.instantiate()
		p2.position=%Marker2D.position
		%NodePlayers.add_child(p2)
		player_2=p2
		
	for i in player_1.hp:
		var pos=Vector2(25+50*i,220)
		var heart =HEART_1.instantiate()
		heart.position=pos
		%NodeHeart.add_child(heart)
	
	%HeadPic2.visible=false
	%WeaponPic2.visible=false
	if player_2:
		%HeadPic2.visible=true
		%WeaponPic2.visible=true
		for i in player_2.hp:
			var pos=Vector2(1920-25-50*i,220)
			var heart =HEART_2.instantiate()
			heart.position=pos
			%NodeHeart2.add_child(heart)
	
	var camera_ranges=%Level01.get_node("CameraRange").get_children()
	%Camera2D.limit_left=camera_ranges[0].position.x
	%Camera2D.limit_top=camera_ranges[0].position.y
	%Camera2D.limit_right=camera_ranges[1].position.x
	%Camera2D.limit_bottom=camera_ranges[1].position.y


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_ui(Global.UI_THEME)
	
	var arr_player=node_players.get_children()
	if arr_player.is_empty():pass
	else:
		var pos_all:Vector2=Vector2.ZERO
		for p:Player in arr_player:pos_all+=p.position
		%Camera2D.position=pos_all/arr_player.size()
	
	if boss_dragon_summoned:
		if enemy_dragon:
			enemy_dragon.move_and_slide()
			%Camera2D.position=enemy_dragon.position+Vector2(0,540)
	else:
		if %Camera2D.position.y>=%MarkerBoss1.position.y:
			enemy_dragon=ENEMY_DRAGON.instantiate()
			enemy_dragon.position=Vector2(960,%Camera2D.position.y-540)
			add_child(enemy_dragon)
			var tween=create_tween()
			tween.tween_property(enemy_dragon,"velocity",Vector2(0,180),2)
			boss_dragon_summoned=true
	if boss_octopus_summoned:
		if enemy_octopus:
			enemy_octopus.move_and_slide()
			%Camera2D.position=enemy_octopus.position-Vector2(0,540)
	else:
		if %Camera2D.position.y>=%Camera2D.limit_bottom:
			enemy_dragon.velocity=Vector2.ZERO
			if enemy_dragon:enemy_dragon.queue_free()
			
			enemy_octopus=ENEMY_OCTOPUS.instantiate()
			enemy_octopus.position=Vector2(960,%Camera2D.position.y-540)
			add_child(enemy_octopus)
			%AreaPass.monitoring=true
			var tween=create_tween()
			tween.tween_property(enemy_octopus,"velocity",Vector2(0,-200),2)
			boss_octopus_summoned=true
			player_1.position.y=%Camera2D.limit_bottom-500
			if player_2:player_2.position.y=%Camera2D.limit_bottom-500
	#检测生命值对齐
	var arr_heart=%NodeHeart.get_children()
	var diff=player_1.hp-arr_heart.size()
	if diff>0:
		for i in diff:
			var pos=Vector2(25+50*arr_heart.size()+50*i,220)
			var heart =HEART_1.instantiate()
			heart.position=pos
			%NodeHeart.add_child(heart)
	if diff<0:
		for i in abs(diff):
			var h=arr_heart.pop_back()
			if h:h.queue_free()
	if player_1.weapon: %WeaponPic.animation_player.play("laser")
	else: %WeaponPic.animation_player.play("shotgun")
	
	if player_2:
		arr_heart=%NodeHeart2.get_children()
		diff=player_2.hp-arr_heart.size()
		if diff>0:
			for i in diff:
				var pos=Vector2(1920-25-arr_heart.size()*50-50*i,220)
				var heart =HEART_2.instantiate()
				heart.position=pos
				%NodeHeart2.add_child(heart)
		if diff<0:
			for i in abs(diff):
				var h=arr_heart.pop_back()
				if h:h.queue_free()
		
		if player_2.weapon: %WeaponPic2.animation_player.play("laser")
		else: %WeaponPic2.animation_player.play("shotgun")
	
	#失败判断
	var is_fail:bool=true
	if player_1.hp>0:is_fail=false
	if player_2:
		if player_2.hp>0:is_fail=false
	if is_fail:Global.switch_ui(Global.UI_FAIL)


func _on_area_2d_body_entered(body: Player) -> void:
	body.position.y+=500
	body.position.x=960
	body.velocity=Vector2.ZERO
	body.try_get_hurt(1)

func _on_area_2d_2_body_entered(body: Player) -> void:
	body.position.y-=500
	body.position.x=960
	body.velocity=Vector2.ZERO
	body.try_get_hurt(1)

func _on_area_pass_body_entered(body: Node2D) -> void:
	Global.switch_ui(Global.UI_WIN)
