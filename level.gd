extends Node2D

@export var BlockScene: PackedScene
@export var PowerUpScene: PackedScene

var _block_count: int
var _block_scale: Vector2
var _offset: Vector2

var power_up_scenes = {
	"chaos": preload("res://power_ups/power_up_chaos.tscn"),
	"confuse": preload("res://power_ups/power_up_confuse.tscn"),
	"increase": preload("res://power_ups/power_up_increase.tscn"),
	"passthrough": preload("res://power_ups/power_up_passthrough.tscn"),
	"speed": preload("res://power_ups/power_up_speed.tscn"),
	"sticky": preload("res://power_ups/power_up_sticky.tscn"),
}


func _ready():
	load_level("res://levels/one.lvl")


#region Level Creation
func load_level(file_name: String):
	var level_content = FileAccess.get_file_as_string(file_name)
	var rows = level_content.split("\n", false)
	var num_of_rows = len(rows)
	var num_of_columns = len(rows[0].split(" ", false))

	_set_level_offsets(num_of_rows, num_of_columns)

	for i in range(num_of_rows):
		var column = rows[i].split(" ", false)
		for j in range(num_of_columns):
			_add_block(int(column[j]), Vector2(_offset.x * j, _offset.y * i))


func _add_block(type: int, location: Vector2):
	var block = BlockScene.instantiate()
	if(type == block.Types.EMPTY):
		return

	block.position = location
	block.scale = _block_scale
	block.type = type
	block.destroyed.connect(_on_block_destroyed)
	add_child(block)
	if(type != block.Types.SOLID):
		_block_count += 1


func _set_level_offsets(rows: int, columns: int):
	var screen_size: Vector2 = get_viewport_rect().size
	var block_size = BlockScene.instantiate().get_size()
	_block_scale.x = screen_size.x / (block_size.x * columns)
	_block_scale.y = (screen_size.y / 2) / (block_size.y * rows)

	_offset.x = block_size.x * _block_scale.x
	_offset.y = block_size.y * _block_scale.y
#endregion


func _should_spawn(chances: int):
	return randi() % chances == 0


func _spawn_power_up(location: Vector2):
	var power_up_scene: PackedScene

	if _should_spawn(75):
		power_up_scene = power_up_scenes["speed"]
	elif _should_spawn(75):
		power_up_scene = power_up_scenes["sticky"]
	elif _should_spawn(75):
		power_up_scene = power_up_scenes["passthrough"]
	elif _should_spawn(75):
		power_up_scene = power_up_scenes["increase"]
	elif _should_spawn(15):
		power_up_scene = power_up_scenes["confuse"]
	elif _should_spawn(15):
		power_up_scene = power_up_scenes["chaos"]

	if power_up_scene != null:
		var power_up = power_up_scene.instantiate()
		power_up.position = location
		add_child(power_up)


func _on_block_destroyed(location: Vector2):
	_block_count -= 1
	_spawn_power_up(location)
