extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	get_node("Wavesheet/AnimationPlayer").play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position+=Vector2(-.75,0)
	
