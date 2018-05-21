extends Area2D

signal coin_picked

var taken=false

func _on_coin_body_enter( body ):
	if not taken and body is preload("res://player.gd"):
		$anim.play("taken")
		taken = true
		emit_signal("coin_picked")
