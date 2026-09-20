extends Control

@onready var camera_flash: ColorRect = $FlashCamera

func _ready() -> void:
	camera_flash.color = Color.WHITE
	camera_flash.modulate.a = 0.0
	camera_flash.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_start_button_pressed() -> void:
	var tween := create_tween()
	tween.tween_property(camera_flash, "modulate:a", 0.9, 0.06)
	tween.tween_property(camera_flash, "modulate:a", 0.0, 0.45)

	await tween.finished
	get_tree().change_scene_to_file("res://scenes/levels/Main_Levels.tscn")


func _on_exit__button_pressed() -> void:
	get_tree().quit()
