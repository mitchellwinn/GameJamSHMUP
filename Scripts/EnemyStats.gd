extends Node

@export var HP : int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(HP<=0):
		get_parent().queue_free()
		get_node("/root/Node2D").score+=get_parent().points
		get_node("/root/Node2D/UI/Score").text = "[center]"+str(get_node("/root/Node2D").score).pad_zeros(6)+"[center]"
	
