extends Node2D

func _ready():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
