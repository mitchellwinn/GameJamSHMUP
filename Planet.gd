extends CSGSphere3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotate_y(0.144/90)
	rotate_x(0.144/300)
