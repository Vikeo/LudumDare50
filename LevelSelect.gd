extends Control

export (PackedScene) var LevelButton
export (int) var total_levels = 0
export (NodePath) var vbox

func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second())
	Globals.score = 0
	vbox = get_node(vbox)
	
	if !total_levels <= 4:
		column_size()
	
	for i in range(0, total_levels):
		generate_buttons(i + 1)
		
func generate_buttons(name : int):
	var ls = LevelButton.instance()
	ls.set_name(str(name))
	ls.set_text(str(name))
	ls.level_path = ("res://Scenes/Levels/" + str(name) + ".tscn")
	print(ls.level_path)
	print(ls)
	vbox.add_child(ls)
	
func column_size():
	if total_levels % 2 == 0:
		vbox.columns = total_levels/2
	else:
		vbox.columns = total_levels/2 + 1
