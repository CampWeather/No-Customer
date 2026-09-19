extends CharacterBody3D

@export_category("Movement")
@export var speed: float = 5.0
@export var acceleration: float = 20.0
@export var deceleration: float = 25.0
@export var jump_velocity: float = 4.5

@export_category("Camera")
@export var mouse_sensitivity: float = 0.002
@export_range(1.0, 89.0, 1.0) var max_look_angle: float = 85.0

@onready var neck: Node3D = $Neck

@export_category("Interaction")
# Pastikan path node ini sesuai dengan susunan di scenemu
@onready var raycast: RayCast3D = $Neck/Camera3D/RayCast3D
@onready var progress_bar = $loading_circle/CanvasLayer/TextureProgressBar

var waktu_tahan: float = 0.0
var durasi_interaksi: float = 2.0
var is_interacting: bool = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	progress_bar.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# Putaran horizontal pada badan pemain.
		rotate_y(-event.relative.x * mouse_sensitivity)

		# Putaran vertikal hanya pada Neck/Camera.
		neck.rotate_x(-event.relative.y * mouse_sensitivity)
		neck.rotation.x = clamp(
			neck.rotation.x,
			deg_to_rad(-max_look_angle),
			deg_to_rad(max_look_angle)
		)

	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Gravitasi.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lompat.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity

	# Membaca input pergerakan.
	var input_dir := Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)

	# Mengubah input menjadi arah berdasarkan rotasi pemain.
	var direction := (
		transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)
	).normalized()

	if direction != Vector3.ZERO:
		velocity.x = move_toward(
			velocity.x,
			direction.x * speed,
			acceleration * delta
		)
		velocity.z = move_toward(
			velocity.z,
			direction.z * speed,
			acceleration * delta
		)
	else:
		velocity.x = move_toward(
			velocity.x,
			0.0,
			deceleration * delta
		)
		velocity.z = move_toward(
			velocity.z,
			0.0,
			deceleration * delta
		)

	move_and_slide()
	
func _process(delta: float) -> void:
	if raycast.is_colliding():
		var target = raycast.get_collider()
		
		if QuestManager.cek_interaksi_rak(target):
			if Input.is_action_pressed("interact"): 
				is_interacting = true
				waktu_tahan += delta
				progress_bar.show()
				progress_bar.value = (waktu_tahan / durasi_interaksi) * 100
				
				if waktu_tahan >= durasi_interaksi:
					QuestManager.selesaikan_rak()
					batal_interaksi()
			else:
				batal_interaksi()
		else:
			batal_interaksi()
	else:
		batal_interaksi()

func batal_interaksi():
	if is_interacting:
		is_interacting = false
		waktu_tahan = 0.0
		progress_bar.hide()
		progress_bar.value = 0
		
