extends Node2D

@onready var label_w = $CanvasLayer/DialoguePanelW/DialogueLabelW
@onready var label_c = $CanvasLayer/DialoguePanelC2/DialogueLabelC
@onready var exit_button = $CanvasLayer/Exit
@onready var chatter_w = $ChatterPlayer
@onready var chatter_c = $ChatterFlipPlayer
@onready var bunny_house = preload("res://scenes/BunnyHouseIn.tscn")
@onready var seagull_house = preload("res://scenes/seagull_house_in.gd")

# [speaker, text, time]
var conversations = {
	"burglary": [
		["W", "Hastings Direct, you're through to the claims team. How can I help?", "09:14"],
		["C", "Hi, I've just come home to find my burrow broken into. Someone smashed my window and stole my TV!", "09:14"],
		["W", "I'm so sorry to hear that. Can I take your policy number please?", "09:15"],
		["C", "Yes, it's 8UNNY-001.", "09:15"],
		["W", "Thank you. Have you reported this to the police and obtained a crime reference number?", "09:15"],
		["C", "Yes, I called them straight away. The reference is H0P-8UN-2024.", "09:16"],
		["W", "Perfect. Theft and forced entry is covered under your Hastings Essential policy. I'll open a claim for you now.", "09:16"],
		["C", "Oh thank goodness.", "09:17"],
		["W", "Is there anything else I can help with?", "09:17"],
		["C", "No, that's everything. Thank you so much!", "09:18"],
		["W", "You're welcome. Take care. Goodbye!", "09:18"],
	],
	"sink": [
		["W", "Hastings Direct claims, how can I help you today?", "11:22"],
		["C", "Hi, I have a bit of a situation. My sink pipe was leaking, so I tried to fix it myself... and I think I made it a lot worse.", "11:22"],
		["W", "I see. Can I take your policy number?", "11:23"],
		["C", "Yes, it's 5EA9ULL-002.", "11:24"],
		["W", "Thank you. I'm not 100% sure whether this is covered without checking further.", "11:24"],
		["C", "Oh... so it might not be?", "11:25"],
		["W", "I'd need to pass this to my manager. Can I take your number and email contact you later?", "11:25"],
		["C", "Of course. It's 07777 777 777 and S_Squawk@coastmail.com.", "11:26"],
		["W", "Perfect. Someone will be in touch later today.", "11:26"],
		["C", "That's okay, thank you for your help.", "11:27"],
		["W", "Of course. Take care. Goodbye!", "11:27"],
	],
	"fire": [
		["W", "Hastings Direct claims, how can I help you today?", "14:02"],
		["C", "There's been a fire in my burrow. The walls, the furniture, everything is damaged!", "14:02"],
		["W", "I'm so sorry. Are you safe? Is everyone out of the property?", "14:03"],
		["C", "Yes, I got out in time. But the damage is terrible.", "14:03"],
		["W", "That's the most important thing. Can I take your policy number?", "14:03"],
		["C", "It's 8UNNY-001.", "14:04"],
		["W", "Thank you. Fire and smoke damage is fully covered under your policy. I'm raising an urgent claim right now.", "14:04"],
		["C", "That's such a relief. Thank you.", "14:05"],
		["W", "Of course. Please don't dispose of any damaged items before the assessor visits. Take care.", "14:05"],
	],
	"storm": [
		["W", "Hastings Direct claims, how can I help you today?", "16:34"],
		["C", "Hi, there's been a storm and a branch came down and smashed straight through my window.", "16:34"],
		["W", "Can I take your policy number?", "16:35"],
		["C", "Yes, it's 5EA9ULL-002.", "16:36"],
		["W", "Thank you. Storm damage and falling branches causing impact damage are covered under your policy.", "16:36"],
		["C", "Wonderful, thank you so much.", "16:38"],
		["W", "Of course. In the meantime, please take some photos of the damage before any repairs are made. Is there anything else I can help with?", "16:38"],
		["C", "No, that's everything. Thank you!", "16:39"],
		["W", "You're welcome. Stay safe. Goodbye!", "16:39"],
	],
}

var current_lines = []
var current_index = 0
var log_w = ""
var log_c = ""

func _ready():
	if GameState.current_character == GameState.Character.BUNNY:
		$Bunny.visible = true
	elif GameState.current_character == GameState.Character.SEAGULL:
		$Seagull.visible = true
	exit_button.visible = false
	label_w.text = ""
	label_c.text = ""

	var claim = ""
	if GameState.current_webpage != null:
		var title = GameState.current_webpage.title.to_lower()
		if "theft" in title or "burgl" in title:
			claim = "burglary"
		elif "fire" in title:
			claim = "fire"
		elif "water" in title:
			claim = "sink"
		elif "storm" in title:
			claim = "storm"

	if claim == "" or not conversations.has(claim):
		claim = "burglary"

	current_lines = conversations[claim]
	_show_line()

func _input(event):
	if exit_button.visible:
		return
	if event.is_action_pressed("ui_accept"):
		current_index += 1
		if current_index < current_lines.size():
			_show_line()
		else:
			_end_call()

func _show_line():
	var speaker = current_lines[current_index][0]
	var text = current_lines[current_index][1]
	var time = current_lines[current_index][2]
	var entry = "[" + time + "]  " + text + "\n\n"

	if speaker == "W":
		log_w += entry
		label_w.text = log_w
		chatter_c.stop()
		chatter_w.play()
	else:
		log_c += entry
		label_c.text = log_c
		chatter_w.stop()
		chatter_c.play()

func _end_call():
	chatter_w.stop()
	chatter_c.stop()
	exit_button.visible = true

func _on_exit_pressed() -> void:
	print("exit pressed")
	if GameState.current_character == GameState.Character.BUNNY:
		print("bunny")
		get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")
	elif GameState.current_character == GameState.Character.SEAGULL:
		print("seagull")
		get_tree().change_scene_to_file("res://scenes/seagull_house_in.tscn")
