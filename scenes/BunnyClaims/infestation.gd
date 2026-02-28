extends Node2D

@onready var bug1 = $bug1
@onready var bug2 = $bug2
@onready var bug3 = $bug3
@onready var bug4 = $bug4
@onready var bug5 = $bug5

func _ready() :
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	bug1.play("run")
	bug2.play("run")
	bug3.play("run")
	bug4.play("run")
	bug5.play("run")
