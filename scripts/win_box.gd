extends Area3D

@onready var win_screen = $"../Control"
@onready var audio: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	if body is CharacterBody3D:
		win_screen.visible = true
		audio.stop()
