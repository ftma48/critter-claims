extends Node2D

var window_scene = preload("res://scenes/window_storm.tscn")
var sink_scene = preload("res://scenes/sink.tscn")
@onready var fly_music = $fly

func _ready():
	fly_music.play()
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func _on_window_pressed() -> void:
	fly_music.stop()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(window_scene)
	
func _on_sink_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(sink_scene)

func _on_exit_pressed() -> void:
	fly_music.stop()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
