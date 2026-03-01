extends Node2D

@onready var fire = $Fire
@onready var label = $CanvasLayer/LabelPanel/Label
@onready var background = $Background
@onready var background_after = $BackgroundAfter
@onready var button_panel = $CanvasLayer/ButtonPanel

var lines = [
	"Yikes! There's a fire in the burrow!",
	"We need to act fast before it spreads!",
	"Let's put it out!"
]
var after_lines = [
	"Oh my goodness... everything is burnt!",
	"I can't believe this happened...",
	"I need to contact my insurance right away!",
	"This is going to be a long day."
]
var current_line = 0
var showing_after_lines = false

func _ready():
	button_panel.visible = false
	GameState.tv_seen = false
	$smoke1.visible = false
	$smoke2.visible = false
	$smoke3.visible = false
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	fire.play("burn")
	$CanvasLayer/LabelPanel.visible = true
	label.text = lines[0]

func _input(event):
	if button_panel.visible:
		return
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		if showing_after_lines:
			if current_line < after_lines.size():
				label.text = after_lines[current_line]
			else:
				$CanvasLayer/LabelPanel.visible = false
				button_panel.visible = true
		else:
			if current_line < lines.size():
				label.text = lines[current_line]
			else:
				$CanvasLayer/LabelPanel.visible = false

func _on_fire_extinguisher_pressed():
	$FireExtinguisher.visible = false
	$FireExtinguisher.disabled = true
	$Fire.visible = false
	$smoke1.visible = true
	$smoke2.visible = true
	$smoke3.visible = true
	$smoke1.play("spray")
	$smoke2.play("spray")
	$smoke3.play("spray")
	await $smoke1.animation_finished
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 0.0, 0.5)
	await tween.finished
	background.visible = false
	background_after.visible = true
	$smoke1.visible = false
	$smoke2.visible = false
	$smoke3.visible = false
	showing_after_lines = true
	current_line = 0
	$CanvasLayer/LabelPanel.visible = true
	label.text = after_lines[0]


func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")
