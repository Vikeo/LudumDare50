extends Control

onready var popup = $WinText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_WinOrb_win() -> void:
	popup.show()
	get_tree().paused = true
