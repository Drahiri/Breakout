extends Node

var levels_scenes := []
var current_level_id := 0

var lifes = 3


func _ready():
	_load_levels()
	$Paddle.set_physics_process(false)
	$Ball.set_physics_process(false)


func _input(_event):
	if Input.is_action_just_pressed("start_game"):
		_start_game()

	if Input.is_action_just_pressed("next_level"):
		current_level_id += 1
		current_level_id %= len(levels_scenes)
		_change_level()

	if Input.is_action_just_pressed("previous_level"):
		current_level_id -= 1
		if current_level_id < 0:
			current_level_id = len(levels_scenes) - 1
		_change_level()


func _start_game():
	set_process_input(false)
	$Paddle.set_physics_process(true)
	$Ball.set_physics_process(true)
	$Effects/Chaos.hide()
	$Effects/Confuse.hide()
	$GUI.start_game(lifes)


func _change_level():
	var level_in_tree = get_node("Level")
	remove_child(level_in_tree)
	$WorldBoundaries.add_sibling(levels_scenes[current_level_id])


func _load_levels():
	var available_levels = DirAccess.get_files_at("res://levels")

	for level_file in available_levels:
		_create_level("res://levels/" + level_file)

	$WorldBoundaries.add_sibling(levels_scenes[current_level_id])


func _create_level(filename: String):
	var level = load("res://level.tscn").instantiate()
	# Add to tree first, otherwise 'get_viewport_rect()' calls error
	$WorldBoundaries.add_sibling(level)
	level.load_level(filename)
	level.scored.connect(_on_scored)
	level.completed.connect(_on_completed)
	remove_child(level)

	levels_scenes.append(level)


func _on_scored():
	$GUI.update_score()


func _on_completed():
	$Paddle.reset()
	$Ball.reset($Paddle.position)
	$GUI.won()
	await get_tree().create_timer(3.0).timeout
	levels_scenes[current_level_id].queue_free()
	print(levels_scenes)
	levels_scenes.remove_at(current_level_id)
	if current_level_id > len(levels_scenes):
		current_level_id -= 1
	_change_level()
	set_process_input(true)
