extends Node2D

@onready var label = $CanvasLayer/Panel/Label
@onready var button_panel = $CanvasLayer/ButtonPanel
@onready var chatter = $ChatterPlayer

var lines = [
	"The sink is leaking!",
	"It looks like a pipe burst!",
	"I need to quickly do something about this..."
]
var after_lines = [
	"Oh no... I made it worse!",
	"I hope my insurance company can fix this.",
	"Let's find out"
]
var current_line = 0
var showing_after_lines = false

func _ready():
	button_panel.visible = false
	$flood.visible = false
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	$CanvasLayer/Panel.visible = true
	label.text = lines[0]
	chatter.play()

func _input(event):
	if button_panel.visible:
		return
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		if showing_after_lines:
			if current_line < after_lines.size():
				label.text = after_lines[current_line]
				chatter.play()
			else:
				$CanvasLayer/Panel.visible = false
				button_panel.visible = true
				chatter.stop()
		else:
			if current_line < lines.size():
				label.text = lines[current_line]
				chatter.play()
			else:
				$CanvasLayer/Panel.visible = false

func _on_tool_pressed() -> void:
	$Tool.visible = false
	$Tool.disabled = true
	$flood.visible = true
	$flood.play("waterfall")
	showing_after_lines = true
	current_line = 0
	$CanvasLayer/Panel.visible = true
	label.text = after_lines[0]
	chatter.play()

func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/seagull_house_in.tscn")

func _on_claim_pressed() -> void:
	GameState.current_webpage = preload("res://webpages/sink_DIY_page.tres")
	get_tree().change_scene_to_file("res://scenes/computer_screen.tscn")
