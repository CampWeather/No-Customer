extends Node3D

# Ini akan memunculkan array di Inspector untuk diisi secara manual
@export var urutan_quest_rak: Array[Node]

func _ready() -> void:
	# Mengirim daftar rak yang sudah kamu susun di Inspector ke Quest Manager
	QuestManager.set_urutan_manual(urutan_quest_rak)
