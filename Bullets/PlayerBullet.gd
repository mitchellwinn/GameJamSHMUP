extends Node2D

var speed = 3.5
var frameActual = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position+=Vector2(1*speed,0)
	frameActual += .5
	$Sprite2D.frame = (floori(frameActual))%6
	
