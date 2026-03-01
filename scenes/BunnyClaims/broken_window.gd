extends Node2D

@onready var label = $CanvasLayer/Panel/Label
@onready var button_panel = $CanvasLayer/ButtonPanel

var lines = []
var current_line = 0

func _ready():
	button_panel.visible = false
	GameState.window_seen = true
	if GameState.tv_seen:
		lines = [
			"Oh! This is how they got in!",
			"Glass is everywhere...",
			"I need to call the police!"
		]
	else:
		lines = [
			"The window is broken!",
			"Someone smashed it...",
			"I wonder what they wanted..."
		]
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	label.text = lines[0]

func _input(event):
	if button_panel.visible:
		return
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		if current_line < lines.size():
			label.text = lines[current_line]
		else:
			if GameState.tv_seen:
				$CanvasLayer/Panel.visible = false
				button_panel.visible = true

func _on_texture_button_pressed():
	pass
	
func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")
