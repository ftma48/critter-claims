extends Node2D

@onready var btn: TextureButton = $TextureButton

func _ready():
	# Yellow background when hovering
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(1.0, 0.9, 0.0, 0.6)
	hover_style.set_corner_radius_all(6)
	btn.add_theme_stylebox_override("hover", hover_style)

	# Connect the button press to switch scenes
	btn.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")


func _on_house_texture_pressed() -> void:
	pass # Replace with function body.
