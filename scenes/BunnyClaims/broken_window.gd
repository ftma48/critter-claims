extends Node2D

@onready var label = $CanvasLayer/Panel/Label
@onready var button_panel = $CanvasLayer/ButtonPanel
@onready var chatter = $ChatterPlayer

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
			button_panel.visible = true
			chatter.stop()



	
func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")

func _on_claim_pressed() -> void:
	GameState.current_webpage = preload("res://webpages/burglary_page.tres")
	get_tree().change_scene_to_file("res://scenes/computer_screen.tscn")
