extends Node2D

func _ready():
	$AnimationPlayer.play("fade_in")


func _on_pan_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/FireHazard.tscn")


func _on_window_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/BrokenWindow.tscn")


func _on_book_shelf_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/Infestation.tscn")
	
	


func _on_table_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/MissingTV.tscn")
