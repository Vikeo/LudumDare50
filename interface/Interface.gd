extends Control

onready var win_popup = $WinText
onready var pause_popup = $PauseScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("go_to_level_select"):
		if pause_popup.on_screen:
			hide_pause_popup()
		else:
			show_pause_popup()

func _on_WinOrb_win() -> void:
	win_popup.show()
	get_tree().paused = true

func show_pause_popup() -> void:
	pause_popup.show()
	pause_popup.on_screen = true
	get_tree().paused = true
	
func hide_pause_popup() -> void:
	pause_popup.hide()
	pause_popup.on_screen = false
	get_tree().paused = false
