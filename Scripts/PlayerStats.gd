extends Node

var HP
var currentHP
var ENERGY
var currentENERGY
var infFrames
var dead=false

# Called when the node enters the scene tree for the first time.
func _ready():
	HP = 8
	ENERGY = 24
	currentHP = HP
	currentENERGY = 12
	infFrames = 0.0
	print ("infFrames:"+str(infFrames))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if currentHP<0:
		currentHP = 0
	elif currentHP>HP:
		currentHP = HP
	if currentENERGY<0:
		currentENERGY = 0
	if currentENERGY > ENERGY:
		currentENERGY = ENERGY
	if infFrames<0:
		infFrames=0
	else:
		infFrames -= 1.0/144.0
	animate()
	if(currentHP<=0&&!dead):
		dead = true
		get_parent().die()
	

	
func animate():
	get_parent().get_parent().get_node("UI/Health").frame = HP-currentHP
	get_parent().get_parent().get_node("UI/Energy").frame = ENERGY-currentENERGY


