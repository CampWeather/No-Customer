extends CharacterBody3D

@onready var quest_marker: Label3D = $"Quest Mark"

var marker_tween: Tween
var posisi_awal_marker: Vector3

func _ready() -> void:
	posisi_awal_marker = quest_marker.position
	quest_marker.visible = QuestManager.quest_berbelanja_selesai

	if not QuestManager.quest_berbelanja_diselesaikan.is_connected(
		tampilkan_tanda_quest
	):
		QuestManager.quest_berbelanja_diselesaikan.connect(
			tampilkan_tanda_quest
		)

	if quest_marker.visible:
		mulai_animasi_marker()


func tampilkan_tanda_quest() -> void:
	quest_marker.show()
	mulai_animasi_marker()


func mulai_animasi_marker() -> void:
	if marker_tween:
		marker_tween.kill()

	quest_marker.position = posisi_awal_marker

	marker_tween = create_tween()
	marker_tween.set_loops()
	marker_tween.set_trans(Tween.TRANS_SINE)
	marker_tween.set_ease(Tween.EASE_IN_OUT)

	marker_tween.tween_property(
		quest_marker,
		"position:y",
		posisi_awal_marker.y + 0.25,
		0.6
	)
	marker_tween.tween_property(
		quest_marker,
		"position:y",
		posisi_awal_marker.y,
		0.6
	)


func quest_diserahkan() -> void:
	if marker_tween:
		marker_tween.kill()
		marker_tween = null

	quest_marker.position = posisi_awal_marker
	quest_marker.hide()
