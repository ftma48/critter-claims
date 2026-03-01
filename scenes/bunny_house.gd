extends Node2D

@onready var animation = $AnimationPlayer
@onready var bunny = $bunny
@onready var happy = $Happy

var move_distance = 300.0
var speed = 150.0
var start_x: float
var can_move: bool = false

func _ready():
	happy.play()
	animation.play("fade_in")
	await animation.animation_finished
	start_x = bunny.position.x
	bunny.play("hop")
	can_move = true

func _process(delta: float) -> void:
	if not can_move:
		return
	if bunny.position.x < start_x + move_distance:
		bunny.position.x += speed * delta 
	else:
		bunny.stop()

func _on_house_texture_pressed() -> void:
	happy.stop()
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")
