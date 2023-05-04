extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("fx spawn")
	$AnimationPlayer.play("default",-1,1,false)
	await get_tree().create_timer(1).timeout
	print("fx delete")
	queue_free()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position=lerp(global_position,get_node("/root/Node2D/Player/SpawnShot").global_position,delta*(19))
