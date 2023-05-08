extends Node2D

var frame = 0
var menuSelection = 0
var startFrame = 0.0
var quitFrame = 0.0
var up = false
var down = false
var left = false
var right = false
var select = false
var selected = false
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
		select = true
	elif event.is_action_released("shoot"):
		select = false

# Called when the node enters the scene tree for the first time.
func _ready():
	fadeIn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frame+=1
	if selected&&menuSelection==0:
		if frame%8<4:
			$Start.visible = false
		else:
			$Start.visible = true
		return
	if selected&&menuSelection==1:
		if frame%8<4:
			$Quit.visible = false
		else:
			$Quit.visible = true
		return
	if menuSelection>1:
		menuSelection = 0
	elif menuSelection<0:
		menuSelection = 1
	if up:
		menuSelection -=1
		up = false
	if down:
		menuSelection +=1
		down = false
	if select:
		fadeOut()
		selected = true
		if menuSelection == 0:
			$Start/sfx.play()
			await get_tree().create_timer(1).timeout
			gameStart()
		elif menuSelection == 1:
			$Quit/sfx.play()
			await get_tree().create_timer(1).timeout
			get_tree().quit()
		
	animate()
	$depths.frame=(frame/140)%6
	$depths.modulate=Color(0,0,0,(sin(frame*3/144.0)+1)/3)
	#$BG.modulate=Color((sin(frame/144.0)+2)/12+.5,0,(sin(frame*2/144.0)+5)/4,1)
	$depths2.modulate=Color(0,0,0,sin(frame*1.75/144.0)+1.5)

func gameStart():
	get_tree().change_scene_to_file("res://Main.tscn")
	pass
	
func fadeOut():
	var opacity = 0
	while opacity<1:
		await get_tree().create_timer(1.0/144).timeout
		opacity+=1.0/144
		$black.modulate = Color(0,0,0,opacity)
		
func fadeIn():
	var opacity = 1
	while opacity>0:
		await get_tree().create_timer(1.0/144).timeout
		opacity-=1.0/144
		$black.modulate = Color(0,0,0,opacity)
	

func animate():
	if menuSelection == 0:
		startFrame = lerpf(startFrame,9.0,.035)
		$Start.frame = startFrame
		quitFrame = lerpf(quitFrame,0.0,.075)
		$Quit.frame = quitFrame
	elif menuSelection == 1:
		startFrame = lerpf(startFrame,0.0,.075)
		$Start.frame = startFrame
		quitFrame = lerpf(quitFrame,9.0,.035)
		$Quit.frame = quitFrame
