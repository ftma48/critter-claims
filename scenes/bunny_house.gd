extends Node2D


func _ready():
	pass
	

func _on_house_texture_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/BunnyHouseIn.tscn")
