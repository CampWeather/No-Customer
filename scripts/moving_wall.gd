extends CSGBox3D

@export var run_distance: float = 2.3   # how far it travels (world units)
@export var run_duration: float = 20.0   # seconds

func start_closing():
	var start_pos := global_position
	var target_pos := start_pos + (global_transform.basis.z) * run_distance

	var tween := create_tween()
	tween.tween_property(self, "global_position", target_pos, run_duration)
