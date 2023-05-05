extends Node2D

var level = 0
var bgSpeed = .02
var fg1Speed = .006

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		scroll(get_node("Node3D/Level_0/bg"),bgSpeed)
		scroll(get_node("Node3D/Level_0/bg3"),bgSpeed*6)
		scroll(get_node("Node3D/Level_0/bg4"),bgSpeed*6)
	
func scroll(thing,speed):
	thing.position-=Vector2(speed,0)
