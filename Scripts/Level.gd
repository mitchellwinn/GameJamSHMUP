extends Node2D

var level = 0
var bgSpeed = .02
var fg1Speed = .006
var frame = 0

var rng= RandomNumberGenerator.new()
var urchin = preload("res://Enemies/Urchin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if level == 0:
		scroll(get_node("Node3D/Level_0/bg"),bgSpeed)
		scroll(get_node("Node3D/Level_0/bg3"),bgSpeed*6)
		scroll(get_node("Node3D/Level_0/bg4"),bgSpeed*6)
		frame+=1
		enemySpawns()	
func scroll(thing,speed):
	thing.position-=Vector2(speed,0)
	
func spawn(obj,pos):
	print("Spawn "+obj.get_name())
	var thisObj = obj.instantiate()
	add_child(thisObj)
	thisObj.global_position = pos
	
func enemySpawns():
	if frame%(144*(5)) == 144*(5)-1:#2 seconds in
			spawn(urchin,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
