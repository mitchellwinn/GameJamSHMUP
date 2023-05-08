extends Node2D

var time = 0
var frame = 0
var n = 0
var startPos = Vector3.ZERO
var points  = 30

var areaHead
var areaBody
var areaLeft
var areaRight
var wave = preload("res://Particles/Wave.tscn")
var energy = preload("res://Particles/energyPickup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	areaHead = $Head/Area2D
	areaBody = $Body/Area2D
	areaLeft = $LeftArm/Area2D
	areaRight = $RightArm/Area2D
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	frame+=1
	if frame == 1:
		startPos = global_position
	if frame%15==0:
		n+=1
		if n>5:
			n=1
		spawn(wave,startPos+Vector2(n*-15,13))
		await get_tree().create_timer(0.1).timeout
		spawn(wave,startPos+Vector2(n*-10,13))
		await get_tree().create_timer(0.1).timeout
		spawn(wave,startPos+Vector2(n*-5,13))
		await get_tree().create_timer(0.1).timeout
		spawn(wave,startPos+Vector2(n*0,13))
	#if !$Stats.dead:
		#global_position+= Vector2(-.25,0)
	if(frame<160):
		areaHead.monitorable = false
		areaHead.monitoring = false
		areaBody.monitorable = false
		areaBody.monitoring = false
		areaRight.monitorable = false
		areaRight.monitoring = false
		areaLeft.monitorable = false
		areaLeft.monitoring = false
		if frame%8<4:
			visible = false
		else:
			visible = true
		return
	else:
		areaHead.monitorable = true
		areaHead.monitoring = true
		areaBody.monitorable = true
		areaBody.monitoring = true
		areaRight.monitorable = true
		areaRight.monitoring = true
		areaLeft.monitorable = true
		areaLeft.monitoring = true
		visible = true
	if !$Stats.dead:
		if(frame>144):
			time+=delta

func spawn(obj,pos):
	#print("Spawn "+obj.get_name())
	var thisObj = obj.instantiate()
	get_parent().add_child(thisObj)
	thisObj.global_position = pos
	return thisObj
	



func _on_area_2d_area_entered(area):
	if $Stats.dead:
		return
	print (area.collision_layer)
	if area.collision_layer==2:#bullet
		$Stats.HP-=area.get_parent().damage
		area.get_parent().explode()
		
func die():
	Help.spawn("explode",$Head.global_position+Vector2(60,20))
	Help.spawn("biggerExplode",$RightArm.global_position+Vector2(-30,-30))
	await get_tree().create_timer(0.3).timeout
	Help.spawn("explode",$Head.global_position+Vector2(50,20))
	await get_tree().create_timer(0.1).timeout
	Help.spawn("explode",$Body.global_position+Vector2(30,10))
	Help.spawn("biggerExplode",$Body.global_position+Vector2(-15,-0))
	await get_tree().create_timer(0.2).timeout
	Help.spawn("explode",$LeftArm.global_position+Vector2(20,20))
	await get_tree().create_timer(0.1).timeout
	Help.spawn("explode",$Head.global_position+Vector2(0,0))
	Help.spawn("biggerExplode",$RightArm.global_position+Vector2(15,30))
	await get_tree().create_timer(0.15).timeout
	Help.spawn("explode",$Body.global_position+Vector2(-10,20))
	await get_tree().create_timer(0.1).timeout
	Help.spawn("explode",$Head.global_position+Vector2(-30,40))
	Help.spawn("biggerExplode",$Body.global_position+Vector2(30,60))
	await get_tree().create_timer(0.1).timeout
	print("REACHEDEDN")
	Help.spawn("explode",$Head.global_position+Vector2(60,20))
	Help.spawn("biggerExplode",$RightArm.global_position+Vector2(-30,-30))
	await get_tree().create_timer(0.3).timeout
	Help.spawn("explode",$Head.global_position+Vector2(50,20))
	await get_tree().create_timer(0.1).timeout
	Help.spawn("explode",$Body.global_position+Vector2(30,10))
	Help.spawn("biggerExplode",$Body.global_position+Vector2(-15,-0))
	await get_tree().create_timer(0.2).timeout
	Help.spawn("explode",$LeftArm.global_position+Vector2(20,20))
	await get_tree().create_timer(0.1).timeout
	Help.spawn("explode",$Head.global_position+Vector2(0,0))
	Help.spawn("biggerExplode",$RightArm.global_position+Vector2(15,30))
	await get_tree().create_timer(0.15).timeout
	Help.spawn("explode",$Body.global_position+Vector2(-10,20))
	await get_tree().create_timer(0.1).timeout
	Help.spawn("explode",$Head.global_position+Vector2(-30,40))
	Help.spawn("biggerExplode",$Body.global_position+Vector2(30,60))
	var thisenergy
	###thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-10,0))
	#thisenergy.linear_velocity = Vector2(-10,0)*6
	thisenergy = spawn(energy,$Head.global_position+Vector2(-5,0))
	thisenergy.linear_velocity = Vector2(5,0)*5.5
	thisenergy = spawn(energy,$Head.global_position+Vector2(-3,0))
	thisenergy.linear_velocity = Vector2(-3,0)*5
	thisenergy = spawn(energy,$Head.global_position+Vector2(3,0))
	thisenergy.linear_velocity = Vector2(-3,0)*4.5
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(5,0))
	#thisenergy.linear_velocity = Vector2(5,0)*4
	thisenergy = spawn(energy,$Head.global_position++Vector2(10,0))
	thisenergy.linear_velocity = Vector2(-10,0)*3.5
	thisenergy = spawn(energy,$Head.global_position+Vector2(-10,0))
	thisenergy.linear_velocity = Vector2(-10,0)*6
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-5,0))
	#thisenergy.linear_velocity = Vector2(5,0)*5.5
	thisenergy = spawn(energy,$Head.global_position+Vector2(-3,0))
	thisenergy.linear_velocity = Vector2(-3,0)*5
	thisenergy = spawn(energy,$Head.global_position+Vector2(3,0))
	thisenergy.linear_velocity = Vector2(3,0)*4.5
	thisenergy = spawn(energy,$Head.global_position+Vector2(5,0))
	thisenergy.linear_velocity = Vector2(5,0)*4
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position++Vector2(10,0))
	#thisenergy.linear_velocity = Vector2(-10,0)*3.5
	
	
	queue_free()
