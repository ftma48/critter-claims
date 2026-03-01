extends MarginContainer

@onready var animation = $AnimationPlayer
@onready var happy = $Happy
var bunny_info = preload("res://scenes/bunny_info.tscn")
var seagull_info = preload("res://scenes/seagull_info.tscn")
@onready var help_box = $HelpBox

func _ready():
	modulate.a = 0
	happy.play()
	animation.play("fade_in")

func _on_bunny_pressed() -> void:
	happy.stop()
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_packed(bunny_info)

func _on_seagull_pressed() -> void:
	happy.stop()
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_packed(seagull_info)

func _on_beaver_pressed() -> void:
	pass

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_help_pressed() -> void:
	help_box.visible = true

func _on_back_pressed() -> void:
	help_box.visible = false

func _on_help_mouse_entered() -> void:
	create_tween().tween_property($"VBoxContainer/VBoxContainer2/Button Container/Help", "scale", Vector2(1.1, 1.1), 0.15)

func _on_help_mouse_exited() -> void:
	create_tween().tween_property($"VBoxContainer/VBoxContainer2/Button Container/Help", "scale", Vector2(1, 1), 0.15)

func _on_exit_mouse_entered() -> void:
	create_tween().tween_property($"VBoxContainer/VBoxContainer2/Button Container/Exit", "scale", Vector2(1.1, 1.1), 0.15)

func _on_exit_mouse_exited() -> void:
	create_tween().tween_property($"VBoxContainer/VBoxContainer2/Button Container/Exit", "scale", Vector2(1, 1), 0.15)

func _on_back_mouse_entered() -> void:
	create_tween().tween_property($HelpBox/TextureRect/VBoxContainer/Back, "scale", Vector2(1.1, 1.1), 0.15)

func _on_back_mouse_exited() -> void:
	create_tween().tween_property($HelpBox/TextureRect/VBoxContainer/Back, "scale", Vector2(1, 1), 0.15)
