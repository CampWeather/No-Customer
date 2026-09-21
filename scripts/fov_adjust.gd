extends Node3D

@onready var Camera: Camera3D = $"CharacterBody3D/Neck/Camera3D"

func _ready() -> void:
	Camera.fov = 120
