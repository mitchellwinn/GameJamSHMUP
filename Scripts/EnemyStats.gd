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
				get_parent().modulate= Color(1,1,1,0.1)
			else:
				get_parent().modulate= Color(1,1,1,1)
	if(HP<=0&&!dead):
		dead = true
		print("die")
		get_parent().die()
		get_node("/root/Node2D").score+=get_parent().points
		get_node("/root/Node2D/UI/Score").text = "[center]"+str(get_node("/root/Node2D").score).pad_zeros(6)+"[center]"
	
