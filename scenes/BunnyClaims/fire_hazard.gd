extends Node2D
@onready var fire = $Fire

func _ready() :
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	fire.play("burn")
