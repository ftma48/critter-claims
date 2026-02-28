extends Node2D

@onready var TV = $Tv

func _ready() :
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	TV.play("Flash")
