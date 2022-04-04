extends Popup

var level_select_path = ("res://LevelSelect.tscn")



func _on_Button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene(level_select_path)

func _on_CloseButton_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_RestartButton_pressed() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_PauseScreen_about_to_show() -> void:
	$CloseButton.grab_focus()
