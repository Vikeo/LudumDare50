extends Control

onready var win_popup = $WinText
onready var pause_popup = $PauseScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_pause"):
		if pause_popup.visible:
			pause_popup.hide()
			get_tree().paused = false
		elif !win_popup.visible:
			pause_popup.show()
			get_tree().paused = true

func _on_WinOrb_win() -> void:
	win_popup.show()
	get_tree().paused = true


