extends Node2D

var frameActual = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frameActual += .1
	$Sprite2D.frame = (floori(frameActual))%6
	if (get_node("/root/Node2D/Player").global_position-global_position).length()<60:
		global_position = lerp(global_position,get_node("/root/Node2D/Player").global_position,(300-(get_node("/root/Node2D/Player").global_position-global_position).length()*5)/2000)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	print("Deleted")
