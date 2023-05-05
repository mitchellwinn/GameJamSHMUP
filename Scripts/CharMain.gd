extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var left = false
var right = false
var up = false
var down = false
var frameMod = 4
var frameModGun = 3.5
var shooting = false
var recoil = false
var rng = RandomNumberGenerator.new()
var playerBullet = preload("res://Bullets/bullet1.tscn")
var shotTimer = 0
var shotRotationMod = 0

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
	shotTimer-=delta
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
	if shooting:
		if shotTimer <= 0:
			shotTimer = .3
			var count = 0
			var burstAmt = 99
			while(count<burstAmt):	
				recoil = true
				var bullet = playerBullet.instantiate()
				var fx = bullet.shootFx.instantiate()
				burstAmt = bullet.burstAmount;
				get_parent().add_child(bullet)
				get_parent().add_child(fx)
				bullet.global_position = $SpawnShot.global_position+$Hands.position
				fx.global_position = $SpawnShot.global_position+$Hands.position-Vector2(6,0)
				count+=1
				await get_tree().create_timer(.02).timeout
			recoil = false
	velocity = velocity.normalized()*144
	move_and_slide()

func _process(delta):
	animate(delta)
	
func animate(delta):
	if velocity.x>0:
		frameMod = lerpf(frameMod,0,delta*8)
		$Girl.rotation = lerpf($Girl.rotation,.075+shotRotationMod,.05)
		$Pack.rotation = lerpf($Pack.rotation,.075+shotRotationMod,.02)
	elif velocity.x==0:
		frameMod = lerpf(frameMod,3.5,delta*8)
		$Girl.rotation = lerpf($Girl.rotation,.0+shotRotationMod,.05)
		$Pack.rotation = lerpf($Pack.rotation,.0+shotRotationMod,.02)
	elif velocity.x<0:
		frameMod = lerpf(frameMod,7,delta*8)
		$Girl.rotation = lerpf($Girl.rotation,-.075+shotRotationMod,.05)
		$Pack.rotation = lerpf($Pack.rotation,-.075+shotRotationMod,.02)
	$Girl.frame=25+frameMod
	$Pack.frame=frameMod
	$Gun.frame=16+frameModGun
	$Hands.frame=8+frameModGun
	$Girl.position = Vector2.ZERO 
	$Pack.position = Vector2.ZERO 
	$Gun.position = Vector2.ZERO 
	$Hands.position = Vector2.ZERO
	if recoil:
		var targetPos = Vector2(rng.randf_range(-2,0),rng.randf_range(-2,2))
		$Gun.position = lerp($Gun.position,targetPos,.3)
		$Hands.position =  lerp($Hands.position,targetPos/2,.3)
		$Gun.frame=16+frameModGun
		$Gun.rotation = lerpf($Gun.rotation,-.055,.3)
		$Hands.rotation = lerpf($Hands.rotation,-.055,.3)
		$Hands.frame=8+frameModGun
		$Girl.position = targetPos/6
		$Pack.position = targetPos/8
		frameModGun = lerpf(frameModGun,7,.3)
		shotRotationMod =-.055
	else:
		$Gun.position = Vector2.ZERO 
		$Gun.rotation = lerpf($Gun.rotation,0,.03)
		$Hands.rotation = lerpf($Hands.rotation,0,.03)
		$Hands.position = Vector2.ZERO
		frameModGun = lerpf(frameModGun,frameMod,.03)
		shotRotationMod =0
