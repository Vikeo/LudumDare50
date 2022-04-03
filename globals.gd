extends Node

var popped : bool = false
var score = 0
var final_score = 0
var balloon_size:float = 0.0

func add_score(amount : int = 1):
	score += amount

func reset_score() -> void:
	score = 0

func set_balloon_size(size : float):
	balloon_size = size

func reset_balloon_size() -> void:
	balloon_size = 0
