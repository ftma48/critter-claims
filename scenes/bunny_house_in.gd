extends Node2D

@onready var glass_sound = $Glass
@onready var happy_music = $Happy
func _ready():
	modulate.a = 0
	happy_music.play()
	$AnimationPlayer.play("fade_in")


func _on_pan_pressed() -> void:
	happy_music.stop()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/FireHazard.tscn")


func _on_window_pressed() -> void:
	happy_music.stop()
	$AnimationPlayer.play("fade_out")
	glass_sound.play()
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/BrokenWindow.tscn")


func _on_book_shelf_pressed() -> void:
	happy_music.stop()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/Infestation.tscn")


func _on_table_pressed() -> void:
	happy_music.stop()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyClaims/MissingTV.tscn")
