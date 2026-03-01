extends Node2D

@onready var label = $CanvasLayer/LabelPanel/Label
@onready var background = $Background
@onready var background_after = $BackgroundAfter
@onready var button_panel = $CanvasLayer/ButtonPanel
@onready var chatter = $ChatterPlayer
@onready var poof = $Poof

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
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	$CanvasLayer/LabelPanel.visible = true
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
				$CanvasLayer/LabelPanel.visible = false
				button_panel.visible = true
				chatter.stop()
		else:
			if current_line < lines.size():
				label.text = lines[current_line]
				chatter.play()
			else:
				$CanvasLayer/LabelPanel.visible = false

func _on_fire_extinguisher_pressed():
	$FireExtinguisher.visible = false
	$FireExtinguisher.disabled = true
	$Fire.visible = false
	$smoke1.visible = true
	$smoke2.visible = true
	$smoke3.visible = true
	poof.play()
	$smoke1.play("spray")
	$smoke2.play("spray")
	$smoke3.play("spray")
	await $smoke1.animation_finished
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 0.0, 0.5)
	await tween.finished
	background.visible = false
	background_after.visible = true
	var tween2 = create_tween()
	tween2.tween_property(background_after, "modulate:a", 1.0, 0.5)
	await tween2.finished
	$smoke1.visible = false
	$smoke2.visible = false
	$smoke3.visible = false
	showing_after_lines = true
	current_line = 0
	$CanvasLayer/LabelPanel.visible = true
	label.text = after_lines[0]
	chatter.play()


func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")


func _on_claim_pressed() -> void:
	GameState.current_webpage = preload("res://webpages/fire_hazard_page.tres")
	get_tree().change_scene_to_file("res://scenes/computer_screen.tscn")
