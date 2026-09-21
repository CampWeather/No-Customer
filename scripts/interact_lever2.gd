extends Node3D

@onready var interact_area: Area3D = $InteractArea

var player_in_range := false
var prompt_tween: Tween

func _ready() -> void:
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

	var label := _get_label()
	if label:
		label.visible = false
		label.modulate.a = 0.0

func _get_label() -> Label:
	return get_tree().get_first_node_in_group("interact_label")

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		player_in_range = true
		_show_prompt()

func _on_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		player_in_range = false
		_hide_prompt()

func _show_prompt() -> void:
	var label := _get_label()
	if not label:
		return
	label.visible = true
	if prompt_tween:
		prompt_tween.kill()
	prompt_tween = create_tween()
	prompt_tween.tween_property(label, "modulate:a", 1.0, 0.2)

func _hide_prompt() -> void:
	var label := _get_label()
	if not label:
		return
	if prompt_tween:
		prompt_tween.kill()
	prompt_tween = create_tween()
	prompt_tween.tween_property(label, "modulate:a", 0.0, 0.2)
	prompt_tween.tween_callback(func(): label.visible = false)

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		_pull_lever()

func _pull_lever() -> void:
	print("Lever pulled!")
	get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")
