extends Node

signal quest_berbelanja_diselesaikan

var material_outline = preload("res://shaders/Outline_Kuning.tres")
var rak_list: Array = []
var rak_sekarang_index: int = 0
var quest_berbelanja_selesai: bool = false

func set_urutan_manual(urutan_rak: Array):
	rak_list = urutan_rak
	rak_sekarang_index = 0

	if rak_list.size() > 0:
		atur_outline(rak_list[rak_sekarang_index], true)


func cek_interaksi_rak(rak_yang_dilihat: Node) -> bool:
	if quest_berbelanja_selesai or rak_list.is_empty():
		return false

	return rak_yang_dilihat == rak_list[rak_sekarang_index]


func selesaikan_rak():
	if rak_list.is_empty():
		return

	atur_outline(rak_list[rak_sekarang_index], false)
	rak_sekarang_index += 1

	if rak_sekarang_index < rak_list.size():
		atur_outline(rak_list[rak_sekarang_index], true)
	else:
		quest_berbelanja_selesai = true
		quest_berbelanja_diselesaikan.emit()
		print("Semua belanjaan terkumpul! Silakan ke Kasir.")


func atur_outline(rak: Node, status: bool):
	if rak is GeometryInstance3D:
		if status:
			rak.material_overlay = material_outline
			print("[VISUAL] Outline dinyalakan untuk: ", rak.name)
		else:
			rak.material_overlay = null
			print("[VISUAL] Outline dimatikan untuk: ", rak.name)
	else:
		print("[ERROR] Node ", rak.name, " tidak mendukung pemasangan material!")
