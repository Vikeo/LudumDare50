extends Popup

var level_select_path = ("res://LevelSelect.tscn")

func _on_Button_pressed() -> void:
	print("hej")
	get_tree().paused = false
	get_tree().change_scene(level_select_path)


func _on_WinText_show() -> void:
	$Button.grab_focus()
