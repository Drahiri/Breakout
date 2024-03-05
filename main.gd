extends Node

var levels_scenes := []
var current_level := 0

var lifes = 3
var score = 0

func _ready():
	_load_levels()
	$Paddle.set_physics_process(false)
	$Ball.set_physics_process(false)


func _input(_event):
	if Input.is_action_just_pressed("start_game"):
		_start_game()

	if Input.is_action_just_pressed("next_level"):
		current_level += 1
		current_level %= len(levels_scenes)
		_change_level()

	if Input.is_action_just_pressed("previous_level"):
		current_level -= 1
		if current_level < 0:
			current_level = len(levels_scenes) - 1
		_change_level()


func _start_game():
	set_process_input(false)
	$Paddle.set_physics_process(true)
	$Ball.set_physics_process(true)
	$Effects/Chaos.hide()
	$Effects/Confuse.hide()
	$GUI.start_game(lifes, score)

func _change_level():
	var level_in_tree = get_node("Level")
	remove_child(level_in_tree)
	$WorldBoundaries.add_sibling(levels_scenes[current_level])

func _load_levels():
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
	level.scored.connect(_on_scored)
	level.completed.connect(_on_completed)
	remove_child(level)

func _on_scored():
	score += 100
	$GUI.update_score(score)


func _on_completed():
	$Paddle.reset()
	$Ball.reset($Paddle.position)
	$GUI.won(score)
	await get_tree().create_timer(3.0).timeout
	levels_scenes[current_level].queue_free()
	levels_scenes.remove_at(current_level)
	if current_level > len(levels_scenes):
		current_level -= 1
	_change_level()
	set_process_input(true)
