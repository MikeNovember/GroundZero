extends Area2D

signal coin_picked

var taken=false

func _ready():
	position = Vector2(rand_range(25.0, 785.0), rand_range(1200.0, 8750.0))

func _on_coin_body_enter( body ):
	if not taken and body is preload("res://player.gd"):
		$anim.play("taken")
		taken = true
		emit_signal("coin_picked")
