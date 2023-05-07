extends Node2D

var frame = 0
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sprite2D/AnimationPlayer").play("default")
	rotation = rng.randi_range(0,4)*(.5*PI)
	position = rng.randi_range(-4,4)*position
	get_node("Sprite2D/AnimationPlayer").speed_scale=rng.randf_range(.2,1)*5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frame+=1
	if(frame>144*2):
		queue_free()

