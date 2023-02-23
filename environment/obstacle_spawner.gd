extends Node2D
onready var timer = $Timer

signal obstacle_created(obs)
var c= 0 
var Obstacle = preload("res://environment/obstacle.tscn")
func _ready():
	randomize()

func _on_Timer_timeout():
	spawn_obstacle()
	
func spawn_obstacle():
	var obstacle = Obstacle.instance()
	add_child(obstacle)
	
	# random no btw 150 and 550 
	obstacle.position.y=randi() % 350 + 180
	Global_var.ob_pos[c]=obstacle.position.y
	if c==3:
		c=0
	c+=1
	
	emit_signal("obstacle_created",obstacle)

func start():
	timer.start()

func stop():
	timer.stop()
