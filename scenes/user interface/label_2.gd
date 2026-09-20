extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var variasi_font := FontVariation.new()
	variasi_font.base_font = $".".get_theme_font("font")
	variasi_font.spacing_glyph = 6

	$".".add_theme_font_override(
		"font",
		variasi_font
	)
