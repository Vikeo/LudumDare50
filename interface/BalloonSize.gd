extends Container

onready var size_bar : Node = $SizeBar

var style = StyleBoxFlat.new()

func _ready() -> void:
	size_bar.add_stylebox_override("panel", style)

func _process(delta: float) -> void:
	set_bar_scale()
	set_bar_color()
	shake_bar()

func set_bar_scale() -> void:
	var scale = clamp(Globals.balloon_size, 0, 10) * 0.1
	size_bar.rect_scale.x = scale

func set_bar_color() -> void:
#	size_bar.get_stylebox().set_bg_color(Color(1 * (Globals.balloon_size * 0.2), 1, 0))
#	size_bar.get_custom_stylebox()
	pass

func shake_bar() -> void:
	pass
