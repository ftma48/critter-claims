extends MarginContainer

@onready var animation = $AnimationPlayer
var bunny_info = preload("res://scenes/bunny_info.tscn")

func _ready():
	modulate.a = 0
	animation.play("fade_in")

func _on_bunny_pressed() -> void:
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_packed(bunny_info)

func _on_beaver_pressed() -> void:
	pass
