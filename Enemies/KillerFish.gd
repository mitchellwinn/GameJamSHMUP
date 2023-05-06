extends Node2D

var time = 0.00000
var frame = 0
var n = 0
var startPos = Vector3.ZERO
var points  = 10
var value = 0.01

var rng = RandomNumberGenerator.new()
var wave = preload("res://Particles/Wave.tscn")
var height = rng.randf_range(2,6)
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Path2D/PathFollow2D").progress_ratio==0.01
	height = rng.randf_range(0.25,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_node("Path2D/PathFollow2D/Sprite2D/AnimationPlayer").play("default")
	frame+=1
	if frame == 1:
		startPos = global_position
	if frame%20==0&&n<1:
		n+=1
		spawn(wave,startPos+Vector2(0,-3))
	global_position+= Vector2(-1.25,0)
	if(frame<0):
		visible = false
	else:
		visible = true
	if(frame>0):
		print("time:"+str(time))
		time+=(2.0/144)*.5
		print("time:"+str(time))
	if(time<1):
		value+=(1.0/144)*.5
	else:
		value-=(1.0/144)*.5
	if value<=0:
		value = 0
	print("value:"+str(value))
	if(time<1):
		$Path2D/PathFollow2D.progress_ratio = lerpf($Path2D/PathFollow2D.progress_ratio,value*height,value)
	else:
		$Path2D/PathFollow2D.progress_ratio = lerpf($Path2D/PathFollow2D.progress_ratio,value*height,1-value)
	if get_node("Path2D/PathFollow2D").progress_ratio==0:
		spawn(wave,global_position+Vector2(0,-6))
		print("underwater")
		queue_free()
func spawn(obj,pos):
	print("Spawn "+obj.get_name())
	var thisObj = obj.instantiate()
	get_parent().add_child(thisObj)
	thisObj.global_position = pos
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()
	#print("Deleted")
	pass


func _on_area_2d_area_entered(area):
	print (area.collision_layer)
	if area.collision_layer==2:#bullet
		$Stats.HP-=area.get_parent().damage
		area.get_parent().explode()
