extends MarginContainer

@onready var animation = $AnimationPlayer
var bunny_house = preload("res://scenes/BunnyHouse.tscn")
var main_menu = preload("res://scenes/MainMenu.tscn")

func _ready():
	modulate.a = 0
	animation.play("fade_in")
	await animation.animation_finished


func _on_select_button_pressed() -> void:
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_packed(bunny_house)

func _on_back_button_pressed() -> void:
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
