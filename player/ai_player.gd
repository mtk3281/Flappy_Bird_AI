extends RigidBody2D
class_name Aiplayer

var started = false
export var FLAP_FORCE = -340
const MAX_ROTATION_DEGREE = -30.0
onready var animation = $AnimationPlayer
onready var hit = $hit
onready var wing = $wing
var alive =true 
var pos=0
signal died


func _ready():
	start()

func _physics_process(_delta):
	if rotation_degrees <= MAX_ROTATION_DEGREE:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREE
	
	if linear_velocity.y > 0 :
		if rotation_degrees <= 90:
			angular_velocity = 5
		else:
			angular_velocity = 0
			
func start():
	if started: return
	started = true
	gravity_scale=0


func flap():
	animation.play("flap")
	wing.play()
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -8

func die():
	hit.play()
	if!alive : return
	alive = false
	animation.stop()
	#emit_signal("died")

func change_pos():
	position.y = Global_var.ob_pos[pos]
	if pos==3:
		pos=0
	pos+=1
