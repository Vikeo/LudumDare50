extends Control

export (PackedScene) var LevelButton
export (int) var total_levels = 0
export (NodePath) var levelBox

func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second())
	Globals.score = 0
	levelBox = get_node(levelBox)
	
	for i in range(0, total_levels):
		generate_buttons(i + 1)
		
func generate_buttons(name : int):
	var ls = LevelButton.instance()
	ls.set_name(str(name))
	ls.set_text(str(name))
	ls.level_path = ("res://Scenes/Levels/" + str(name) + ".tscn")
	print(ls.level_path)
	print(ls)
	levelBox.add_child(ls)
	
func column_size():
	if total_levels % 2 == 0:
		levelBox.columns = total_levels/2
	else:
		levelBox.columns = total_levels/2 + 1
