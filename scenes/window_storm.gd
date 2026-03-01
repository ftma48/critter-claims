extends Node2D

@onready var label = $CanvasLayer/Panel/Label
@onready var button_panel = $CanvasLayer/ButtonPanel
@onready var chatter = $ChatterPlayer
@onready var glass_sound = $Glass

var lines = []
var current_line = 0

func _ready():
	button_panel.visible = false
	lines = [
		"The window is broken!",
		"It looks like this branch smashed it in.",
		"It must have been the storm last night!",
		"I should report this to my insurance company..."
	]
	glass_sound.play()
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	label.text = lines[0]
	chatter.play()

func _input(event):
	if button_panel.visible:
		return
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		if current_line < lines.size():
			label.text = lines[current_line]
			chatter.play()
		else:
			$CanvasLayer/Panel.visible = false
			chatter.stop()
			button_panel.visible = true

func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/seagull_house_in.tscn")

func _on_claim_pressed() -> void:
	GameState.current_webpage = preload("res://webpages/storm_damage.tres")
	get_tree().change_scene_to_file("res://scenes/computer_screen.tscn")
