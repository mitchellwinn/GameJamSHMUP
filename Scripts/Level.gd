extends Node2D

var level = 0
var bgSpeed = .02
var fg1Speed = .006
var frame = 0
var score = 0

var rng= RandomNumberGenerator.new()
var urchin = preload("res://Enemies/Urchin.tscn")
var killerFish = preload("res://Enemies/KillerFish.tscn")
var player = preload("res://Player.tscn")


func fadeIn():
	var opacity = 1
	while opacity>0:
		await get_tree().create_timer(1.0/144).timeout
		opacity-=1.0/144
		$UI/black.modulate = Color(0,0,0,opacity)
		
func fadeOut():
	var opacity = 0
	while opacity<1:
		await get_tree().create_timer(1.0/144).timeout
		opacity+=1.0/144
		$UI/black.modulate = Color(0,0,0,opacity)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn(player,Vector2(100,100))
	fadeIn()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if level == 0:
		scroll(get_node("Node3D/Level_0/bg"),bgSpeed)
		scroll(get_node("Node3D/Level_0/bg3"),bgSpeed*6)
		scroll(get_node("Node3D/Level_0/bg4"),bgSpeed*6)
		frame+=1
		enemySpawns()	
func scroll(thing,speed):
	thing.position-=Vector2(speed,0)
	
func spawn(obj,pos):
	print("Spawn "+obj.get_name())
	var thisObj = obj.instantiate()
	add_child(thisObj)
	thisObj.global_position = pos
	
func enemySpawns():
	if frame%(144*(5)) == 144*(5)-1:#5 seconds in
			spawn(urchin,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
	if frame%(144*(3)) == 144*(3)-1 && rng.randf_range(0,1)>.6:#3 seconds in
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			await get_tree().create_timer(.2).timeout
			spawn(killerFish,$OceanSpawns.get_curve().get_point_position(rng.randi_range(0,9))+$OceanSpawns.global_position)
			
