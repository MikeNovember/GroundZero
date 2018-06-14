extends KinematicBody2D

signal win
signal lose
signal shoot

const FLOOR_NORMAL = Vector2(0, -1)
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 300 # pixels/sec
const JUMP_SPEED = 480
const FALLING_SPEED = 200
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000
const SHOOT_TIME_SHOW_WEAPON = 0.2

var linear_vel = Vector2()

var coins = 5;

#cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $sprite

var extra_speed = 0
var speed_constant = 5

func _ready():
	linear_vel.y = FALLING_SPEED

func _is_on_left_edge(position_x,velocity):
	return (position_x <= 25 and linear_vel.x < 0)
func _is_on_right_edge(position_x,velocity):
	return (position_x >= 785 and linear_vel.x > 0)

func _physics_process(delta):
	### MOVEMENT ###
	var pos = get_global_position()
	
	if _is_on_left_edge(pos.x,linear_vel.x) or _is_on_right_edge(pos.x,linear_vel.x):
		linear_vel.x = 0
	
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL)
	linear_vel.y = FALLING_SPEED + extra_speed

#	if is_on_floor() || is_on_ceiling() || is_on_wall():
		#emit_signal("lose")

		

	# Horizontal Movement
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed += -1
	if Input.is_action_pressed("move_right"):
		target_speed +=  1
	if Input.is_action_pressed("move_down"):
		extra_speed = extra_speed + speed_constant
	if Input.is_action_pressed("move_up"):
		if extra_speed > 0:
			extra_speed = extra_speed - speed_constant
		

	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

	# Shooting
	if Input.is_action_just_pressed("shoot") and coins > 0:
		get_node("shoot_sound").play(0)
		var bullet = preload("res://bullet.tscn").instance()
		bullet.position = $sprite/bullet_shoot.global_position #use node for shoot position
		bullet.linear_velocity = Vector2(0, BULLET_VELOCITY)
		bullet.add_collision_exception_with(self) # don't want player to collide with bullet
		get_parent().add_child(bullet) #don't want bullet to move with me, so add it as child of parent
		$sound_shoot.play()
		coins -= 1
		emit_signal('shoot')

func _on_finish_area_reached():
	linear_vel.y = 0

func on_coin_picked():
	coins += 1
