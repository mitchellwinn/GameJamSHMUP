extends Node2D

var speed = 3.5
var frameActual = 0
var burstAmount = 6
var damage = 3
var energyLoss = 1
var shootFx = preload("res://Bullets/hitEffect1.tscn")
var explodeParticle = preload("res://Particles/explode.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position+=Vector2(1*speed,0)
	frameActual += .5		
	$Sprite2D.frame = (floori(frameActual))%6


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func explode():
	var obj = explodeParticle.instantiate()
	get_parent().add_child(obj)
	obj.global_position = global_position
	queue_free()
