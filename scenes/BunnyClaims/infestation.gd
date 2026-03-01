extends Node2D

@onready var bug1 = $bug1
@onready var bug2 = $bug2
@onready var bug3 = $bug3
@onready var bug4 = $bug4
@onready var bug5 = $bug5
@onready var label = $CanvasLayer/Panel/Label
@onready var button_panel = $CanvasLayer/ButtonPanel
@onready var chatter = $ChatterPlayer
@onready var bug_sound = $Ants

var lines = [
	"Eww, bugs everywhere!",
	"This burrow has an infestation!",
	"We have to get rid of them!",
	"Hopefully my insurance will cover my furniture..."
]
var current_line = 0

func _ready():
	button_panel.visible = false
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	bug1.play("run")
	bug2.play("run")
	bug3.play("run")
	bug4.play("run")
	bug5.play("run")
	bug_sound.play()
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
			bug_sound.stop()


	
func _on_exit_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")


func _on_claim_pressed() -> void:
	GameState.current_webpage = preload("res://webpages/infestation_page.tres")
	get_tree().change_scene_to_file("res://scenes/computer_screen.tscn")
