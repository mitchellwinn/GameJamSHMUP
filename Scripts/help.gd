extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(name,pos):
	var obj = load("res://Particles/"+name+".tscn")
	var thisObj = obj.instantiate()
	get_node("/root/Node2D").add_child(thisObj)
	#get_node("/root/Node2D").remove_child(thisObj)
	thisObj.global_position = pos
