extends KinematicBody2D

const WALK_SPEED = 140
const STATE_WALKING = 0
const STATE_KILLED = 1

signal enemy_killed

var linear_velocity = Vector2()
var direction = 1
var anim=""

var state = STATE_WALKING

onready var sprite = $sprite

func _physics_process(delta):
	var new_anim = "idle"

	if state==STATE_WALKING:
		if is_on_wall():
			direction *= -1.0

		linear_velocity.x = direction * WALK_SPEED
		linear_velocity = move_and_slide(linear_velocity)

		sprite.scale = Vector2(direction, 1.0)
		new_anim = "walk"
	else:
		new_anim = "explode"


	if anim != new_anim:
		anim = new_anim
		$anim.play(anim)

func _ready():
	position = Vector2(rand_range(25.0, 785.0), rand_range(1500.0, 8750.0))
	set_collision_layer_bit(1,true)
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, false)

func hit_by_bullet():
	state = STATE_KILLED
	set_collision_layer_bit(1,false)
	set_collision_layer_bit(0,false)
	emit_signal("enemy_killed")
	