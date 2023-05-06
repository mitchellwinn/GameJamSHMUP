extends Node2D

var time = 0
var frame = 0
var n = 0
var startPos = Vector3.ZERO
var points  = 30

var wave = preload("res://Particles/Wave.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	frame+=1
	if frame == 1:
		startPos = global_position
	if frame%30==0&&n<4:
		n+=1
		spawn(wave,startPos+Vector2(0,3))
	global_position+= Vector2(-.25,0)
	if(frame<80):
		visible = false
	else:
		visible = true
	if(frame>144):
		time+=delta
		$Path2D/PathFollow2D.progress_ratio = (sin(time-1)+1)/2

func spawn(obj,pos):
	print("Spawn "+obj.get_name())
	var thisObj = obj.instantiate()
	get_parent().add_child(thisObj)
	thisObj.global_position = pos
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	print("Deleted")


func _on_area_2d_area_entered(area):
	print (area.collision_layer)
	if area.collision_layer==2:#bullet
		$Stats.HP-=area.get_parent().damage
		area.get_parent().explode()
