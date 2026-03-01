extends MarginContainer

@onready var animation = $AnimationPlayer
@onready var happy = $Happy
var bunny_info = preload("res://scenes/bunny_info.tscn")
var seagull_info = preload("res://scenes/seagull_info.tscn")

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
