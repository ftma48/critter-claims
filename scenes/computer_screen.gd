extends Control

@export var webpage: WebPageData

@onready var dialogue_panel = $CanvasLayer/DialoguePanel
@onready var dialogue_label = $CanvasLayer/DialoguePanel/DialogueLabel
@onready var webpage_node = $webpage
@onready var chatter = $ChatterPlayer
@onready var ringing = $Ringing

var essential_page = preload("res://webpages/my_insurance_essential.tres")
var premier_page = preload("res://webpages/my_insurance_premier.tres")
var bunny_house = "res://scenes/BunnyHouseIn.tscn"
var seagull_house = "res://scenes/SeagullHouseIn.tscn"
var lines: Array = []
var current_line = 0

func _ready():
	if webpage == null and GameState.current_webpage != null:
		webpage = GameState.current_webpage
	
	_load_page(_get_default_page())
	
	webpage_node.visible = true
	$CallButton.visible = false
	$CanvasLayer/Exit.visible = false

	if webpage and webpage.dialogue.size() > 0:
		lines = webpage.dialogue
		dialogue_panel.visible = true
		dialogue_label.text = lines[0]
		chatter.play()
	else:
		dialogue_panel.visible = false

func _get_default_page() -> WebPageData:
	match GameState.plan_type:
		GameState.PlanType.ESSENTIAL:
			return essential_page
		GameState.PlanType.PREMIER:
			return premier_page
	return essential_page

func _get_house_scene() -> String:
	match GameState.current_character:
		GameState.Character.BUNNY:
			return "res://scenes/BunnyHouseIn.tscn"
		GameState.Character.SEAGULL:
			return "res://scenes/SeagullHouseIn.tscn"
	return "res://scenes/BunnyHouseIn.tscn"

func _input(event):
	if not dialogue_panel.visible:
		return
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		if current_line < lines.size():
			dialogue_label.text = lines[current_line]
			chatter.play()
		else:
			dialogue_panel.visible = false
			chatter.stop()
			_load_page(webpage)
			$CallButton.visible = webpage.call
			$CanvasLayer/Exit.visible = not webpage.call

func _load_page(page: WebPageData):
	if page:
		$webpage/TitleLabel.text = page.title
		$webpage/ScrollContainer/ContentLabel.text = page.content

func _on_exit_pressed() -> void:
	var tree = get_tree()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	tree.change_scene_to_file(_get_house_scene())


func _on_call_button_pressed() -> void:
	ringing.play()
	var tree = get_tree()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	tree.change_scene_to_file("res://scenes/ClaimCall.tscn")
