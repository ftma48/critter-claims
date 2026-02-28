extends Node2D

func _ready():
	pass


func _on_pan_pressed() -> void:
	$AnimationPlayer.play("fade_")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/FireHazard.tscn")


func _on_window_pressed() -> void:
	$AnimationPlayer.play("fade_")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BrokenWindow.tscn")
