extends MarginContainer

func _on_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/BunnyHouse.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
