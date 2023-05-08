extends Node2D

var time = 0.00000
var frame = 0
var n = 0
var startPos = Vector3.ZERO
var points  = 20
var value = 0.01
var timer = 0

var rng = RandomNumberGenerator.new()
var wave = preload("res://Particles/Wave.tscn")
var energy = preload("res://Particles/energyPickup.tscn")
var height = 0
var area
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Path2D/PathFollow2D").progress_ratio==0
	height = 0
	area = $Path2D/PathFollow2D/Sprite2D/Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_node("Path2D/PathFollow2D/Sprite2D/AnimationPlayer").play("default")
	frame+=1
	if frame == 1:
		startPos = global_position
	if frame%10==0&&n<10:
		n+=1
		spawn(wave,startPos+Vector2(0,-3))
	if !$Stats.dead:
		global_position+= Vector2(-.7,0)
	if(frame<80):
		visible = false
		area.monitorable = false
		area.monitoring = false
	else:
		visible = true
		area.monitorable = true
		area.monitoring = true
	if(frame>0):
		#print("time:"+str(time))
		time+=(2.0/144)*.5
		#print("time:"+str(time))
	if(time<1):
		value+=(1.0/144)*.5
	else:
		value-=(1.0/144)*.5
	if value<=0:
		value = 0
	#print("value:"+str(value))
	if !$Stats.dead:
		if(time<1):
			$Path2D/PathFollow2D.progress_ratio = lerpf($Path2D/PathFollow2D.progress_ratio,value*height,value)
		else:
			$Path2D/PathFollow2D.progress_ratio = lerpf($Path2D/PathFollow2D.progress_ratio,value*height,1-value)
	timer-=1.0/144
	if $Path2D/PathFollow2D/Sprite2D.frame==0:
		if timer <=0:
			timer = .1
			spawn(wave,global_position+Vector2(0,3))
		#print("underwater")
func spawn(obj,pos):
	#print("Spawn "+obj.get_name())
	var thisObj = obj.instantiate()
	get_parent().add_child(thisObj)
	thisObj.global_position = pos
	return thisObj
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()
	#print("Deleted")
	pass


func _on_area_2d_area_entered(area):
	#print (area.collision_layer)
	if $Stats.dead:
		return
	if area.collision_layer==2:#bullet
		$Stats.HP-=area.get_parent().damage
		area.get_parent().explode()
		
func die():
	var thisenergy
	Help.spawn("biggerExplode",$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(2,-2))
	await get_tree().create_timer(.2).timeout
	Help.spawn("biggerExplode",$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-2,2))
	###thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-10,0))
	#thisenergy.linear_velocity = Vector2(-10,0)*6
	Help.spawn("energyPickup",$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(0,-0))
	thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(5,0))
	thisenergy.linear_velocity = Vector2(5,-4)*5.5
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-3,0))
	#thisenergy.linear_velocity = Vector2(-3,4)*5
	thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-3,0))
	thisenergy.linear_velocity = Vector2(-3,-6)*4.5
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(5,0))
	#thisenergy.linear_velocity = Vector2(5,0)*4
	thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position++Vector2(-10,0))
	thisenergy.linear_velocity = Vector2(-10,-4)*3.5
	thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(10,0))
	thisenergy.linear_velocity = Vector2(-10,-8)*6
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-5,0))
	#thisenergy.linear_velocity = Vector2(5,0)*5.5
	thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(3,0))
	thisenergy.linear_velocity = Vector2(-3,-4)*5
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(3,0))
	#thisenergy.linear_velocity = Vector2(-3,5)*4.5
	thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position+Vector2(-5,0))
	thisenergy.linear_velocity = Vector2(5,-4)*4
	#thisenergy = spawn(energy,$Path2D/PathFollow2D/Sprite2D.global_position++Vector2(10,0))
	#thisenergy.linear_velocity = Vector2(-10,0)*3.5
	queue_free()
