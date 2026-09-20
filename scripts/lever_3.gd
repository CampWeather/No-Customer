extends StaticBody3D

func _ready() -> void:
	get_viewport().physics_object_picking = true
	mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level4.tscn")
