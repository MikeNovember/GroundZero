extends KinematicBody2D

const STATE_WALKING = 0
const STATE_KILLED = 1

var state = STATE_WALKING

# Member variables
export var motion = Vector2()
export var cycle = 1.0
var accum = 0.0

func _physics_process(delta):
	accum += delta * (1.0 / cycle) * PI * 2.0
	accum = fmod(accum, PI * 2.0)
	var d = sin(accum)
	var xf = Transform2D()
	xf[2]= motion * d
	transform = xf

func hit_by_bullet():
	state = STATE_KILLED
