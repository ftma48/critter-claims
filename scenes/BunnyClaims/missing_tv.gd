extends Node2D

@onready var TV = $Tv
@onready var label = $CanvasLayer/Panel/Label
@onready var button_panel = $CanvasLayer/ButtonPanel
@onready var chatter = $ChatterPlayer

var lines = []
var current_line = 0

func _ready():
	button_panel.visible = false
	GameState.tv_seen = true
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	TV.play("Flash")

	if GameState.window_seen:
		lines = [
			"Oh no! They stole my TV!",
			"I can't afford to replace it...",
			"I need to make a claim!"
		]
	else:
		lines = [
			"Oh no... where did my TV go?",
			"Someone must have taken it!",
			"How did they even get in?"
		]
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
			if GameState.window_seen:
				$CanvasLayer/Panel.visible = false
				button_panel.visible = true





func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")


func _on_claim_pressed() -> void:
	GameState.current_webpage = preload("res://webpages/burglary_page.tres")
	get_tree().change_scene_to_file("res://scenes/computer_screen.tscn")
