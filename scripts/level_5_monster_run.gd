extends Node3D

@onready var monster = $"Monster_Running"
@onready var monster_run_box = $"MonsterRunBox"
@onready var animator: AnimationPlayer = $"Monster_Running/AnimationPlayer"
@onready var wall_closing = $"Moving_Wall"

var debounce = false

func _ready():
	monster_run_box.body_entered.connect(_on_monster_run_box_body)
	
func _on_monster_run_box_body(body) -> void:
	if body is CharacterBody3D and not debounce:
		debounce = true
		print("Hello!")
		monster.start_running()
		wall_closing.start_closing()
