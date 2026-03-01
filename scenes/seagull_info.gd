extends MarginContainer

@onready var animation = $AnimationPlayer
var seagull_house = preload("res://scenes/SeagullHouse.tscn")
var main_menu = preload("res://scenes/MainMenu.tscn")
@onready var happy = $Happy

func _ready():
	happy.play()
	$HSplitContainer/CenterContainer/seagull.play("default")
	modulate.a = 0
	animation.play("fade_in")
	await animation.animation_finished

func _on_select_button_pressed() -> void:
	animation.play("fade_out")
	await animation.animation_finished
	GameState.plan_type = GameState.PlanType.PREMIER
	GameState.current_character = GameState.Character.SEAGULL
	get_tree().change_scene_to_packed(seagull_house)

func _on_back_button_pressed() -> void:
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_button_mouse_entered() -> void:
	create_tween().tween_property($"HSplitContainer/CenterContainer2/Panel/VBoxContainer/Button Container/Button", "scale", Vector2(1.1, 1.1), 0.15)

func _on_button_mouse_exited() -> void:
	create_tween().tween_property($"HSplitContainer/CenterContainer2/Panel/VBoxContainer/Button Container/Button", "scale", Vector2(1, 1), 0.15)

func _on_button_2_mouse_entered() -> void:
	create_tween().tween_property($"HSplitContainer/CenterContainer2/Panel/VBoxContainer/Button Container/Button2", "scale", Vector2(1.1, 1.1), 0.15)

func _on_button_2_mouse_exited() -> void:
	create_tween().tween_property($"HSplitContainer/CenterContainer2/Panel/VBoxContainer/Button Container/Button2", "scale", Vector2(1, 1), 0.15)
