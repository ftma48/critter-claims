extends Node2D

func _ready():
	pass


func _on_pan_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/FireHazard.tscn")
