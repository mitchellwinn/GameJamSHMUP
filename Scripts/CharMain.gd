extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var left = false
var right = false
var up = false
var down = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):

	if event.is_action("left"):
		left = true
	elif event.is_action_released("left"):
		left = false
	if event.is_action("right"):
		right = true
	elif event.is_action_released("right"):
		right = false
	if event.is_action("up"):
		up = true
	elif event.is_action_released("up"):
		up = false
	if event.is_action("down"):
		down = true
	elif event.is_action_released("down"):
		down = false

func _physics_process(delta):
	velocity = Vector2.ZERO
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if left:
		velocity.x = -144
	elif right:
		velocity.x = 144
	elif up:
		velocity.y = -144
	elif down:
		velocity.y = 144

	move_and_slide()
