extends Node

@export var HP : int
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if dead:
		if get_parent().frame%8<4:
			get_parent().get_node("Path2D/PathFollow2D/Sprite2D").visible = false
		else:
			get_parent().get_node("Path2D/PathFollow2D/Sprite2D").visible = true
	if(HP<=0&&!dead):
		dead = true
		print("die")
		get_parent().die()
		get_node("/root/Node2D").score+=get_parent().points
		get_node("/root/Node2D/UI/Score").text = "[center]"+str(get_node("/root/Node2D").score).pad_zeros(6)+"[center]"
	
