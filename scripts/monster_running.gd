extends Node3D

@export var run_distance: float = 20.0   # how far it travels (world units)
@export var run_duration: float = 20.0   # seconds

@onready var hit_box: Area3D = $Area3D

func _ready():
	hit_box.body_entered.connect(_on_hit_box_body_entered)
	
func _on_hit_box_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("")
		get_tree().quit()

func start_running() -> void:
	var anim: Animation = $AnimationPlayer.get_animation("mixamo_com")
	anim.loop_mode = Animation.LOOP_LINEAR
	$AnimationPlayer.play("mixamo_com")
	var start_pos := global_position
	# -Z is Godot's "forward" by convention — flip the sign/axis if your model faces a different way
	var target_pos := start_pos + (global_transform.basis.z) * run_distance

	var tween := create_tween()
	tween.tween_property(self, "global_position", target_pos, run_duration)
