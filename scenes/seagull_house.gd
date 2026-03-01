extends Node2D

@onready var animation = $AnimationPlayer
@onready var seagull = $seagull

var move_distance = 300.0
var speed = 150.0
var start_x: float
var can_move: bool = false

func _ready():
	animation.play("fade_in")
	await animation.animation_finished
	start_x = seagull.position.x
	seagull.play("fly")
	can_move = true

func _process(delta: float) -> void:
	if not can_move:
		return
	if seagull.position.x < start_x + move_distance:
		seagull.position.x += speed * delta 
	else:
		seagull.stop()

func _on_house_texture_pressed() -> void:
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://scenes/seagull_house_in.tscn")
