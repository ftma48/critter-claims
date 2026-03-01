extends MarginContainer

@onready var animation = $AnimationPlayer
@onready var happy = $Happy
var bunny_house = preload("res://scenes/BunnyHouse.tscn")
var main_menu = preload("res://scenes/MainMenu.tscn")

func _ready():
	$HSplitContainer/CenterContainer/bunny.play("default")
	modulate.a = 0
	happy.play()
	animation.play("fade_in")
	await animation.animation_finished

func _on_select_button_pressed() -> void:
	happy.stop()
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_packed(bunny_house)

func _on_back_button_pressed() -> void:
	happy.stop()
	GameState.plan_type = GameState.PlanType.ESSENTIAL
	GameState.current_character = GameState.Character.BUNNY
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
