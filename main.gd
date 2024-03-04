extends Node

var levels_scenes := []
var current_level := 0

func _ready():
	var available_levels = DirAccess.get_files_at("res://levels")

	for level_file in available_levels:
		_create_level("res://levels/" + level_file)

	$WorldBoundaries.add_sibling(levels_scenes[current_level])


func _create_level(filename: String):
	var level = load("res://level.tscn").instantiate()
	# Has to first add to tree as get_viewport_rect() calls error otherwise
	$WorldBoundaries.add_sibling(level)
	level.load_level(filename)
	levels_scenes.append(level)
	remove_child(level)
