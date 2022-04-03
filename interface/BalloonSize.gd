extends Container

onready var size_bar : Node = $SizeBar
onready var tween : Tween = $ShakeTween

var style = StyleBoxFlat.new()

func _ready() -> void:
	size_bar.add_stylebox_override("panel", style)

func _process(delta: float) -> void:
	var modifier = clamp(Globals.balloon_size, 0, 10) * 0.1
	set_bar_scale(modifier)
	set_bar_color(modifier)
	if modifier > 0.5:
		shake_bar(modifier)

func set_bar_scale(modifier: float) -> void:
	size_bar.rect_scale.x = modifier

func set_bar_color(modifier : float) -> void:
	if Globals.popped:
		style.bg_color = Color(0, 0, 0)
	style.bg_color = Color(1, 1 - modifier, 0)

func shake_bar(modifier: float) -> void:
	if Globals.popped:
		return
	if tween.is_active():
		return
	var values = get_tween_values(modifier)
	var interval = 0.1 * (0.8 - modifier * 0.5)
	tween.interpolate_property(self, "rect_rotation", values[0], values[1], interval)
	tween.start()

func get_tween_values(modifier : float) -> Array:
	var shake_value : float = rand_range(-1.0, 1.0) * (modifier * 2)
	return [size_bar.rect_rotation, shake_value]
