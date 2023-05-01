extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var left = false
var right = false
var up = false
var down = false
var frameMod = 3
var frameModGun = 3
var shooting = false
var rng = RandomNumberGenerator.new()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):

	if event.is_action_pressed("left"):
		left = true
	elif event.is_action_released("left"):
		left = false
	if event.is_action_pressed("right"):
		right = true
	elif event.is_action_released("right"):
		right = false
	if event.is_action_pressed("up"):
		up = true
	elif event.is_action_released("up"):
		up = false
	if event.is_action_pressed("down"):
		down = true
	elif event.is_action_released("down"):
		down = false
	if event.is_action_pressed("shoot"):
		shooting = true
	elif event.is_action_released("shoot"):
		shooting = false

func _physics_process(delta):
	velocity = Vector2.ZERO
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if left:
		velocity.x += -144
	if right:
		velocity.x += 144
	if up:
		velocity.y += -144
	if down:
		velocity.y += 144
	move_and_slide()

func _process(delta):
	animate(delta)
	
func animate(delta):
	if velocity.x>0:
		frameMod = lerpf(frameMod,0,delta*8)
	elif velocity.x==0:
		frameMod = lerpf(frameMod,3,delta*8)
	elif velocity.x<0:
		frameMod = lerpf(frameMod,7,delta*8)
	$Girl.frame=25+frameMod
	$Pack.frame=frameMod
	$Gun.frame=16+frameModGun
	$Hands.frame=8+frameModGun
	$Gun.position = Vector2.ZERO 
	$Hands.position = Vector2.ZERO
	if shooting:
		var targetPos = Vector2(rng.randf_range(-2,0),rng.randf_range(-2,2))
		$Gun.position = lerp($Gun.position,targetPos,delta*80)
		#$Hands.position =  lerp($Hands.position,targetPos,delta*80)
		$Gun.frame=16+frameModGun
		$Hands.frame=8+frameModGun
		frameModGun = lerpf(frameModGun,7,delta*16)
	else:
		$Gun.position = Vector2.ZERO 
		$Hands.position = Vector2.ZERO
		frameModGun = lerpf(frameModGun,frameMod,delta*9)
