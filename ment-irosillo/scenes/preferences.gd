extends ColorRect



func _ready() -> void:
	$CenterContainer/VBoxContainer/VolumeSlider.value = Globals.volume
	$CenterContainer/VBoxContainer/FullScreenBox.button_pressed = Globals.full_screen
func _on_full_screen_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_volume_slider_value_changed(value: float) -> void:
	Globals.volume_changed(value)


func _on_back_button_pressed() -> void:
	visible = false
	Globals.save_preferences()
