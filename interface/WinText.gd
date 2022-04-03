extends Popup

var level_select_path = ("res://LevelSelect.tscn")

func _on_Button_pressed() -> void:
	print("hej")
	get_tree().change_scene(level_select_path)


func _on_Button_button_down() -> void:
	print("hej")
	get_tree().change_scene(level_select_path)
