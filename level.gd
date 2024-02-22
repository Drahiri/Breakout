extends Node2D

@export var BlockScene: PackedScene

var _block_count: int
var _block_scale: Vector2
var _offset: Vector2

@onready var _screen_size: Vector2 = get_viewport_rect().size


func _ready():
	load_level("res://levels/one.lvl")


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
	var block_size = BlockScene.instantiate().get_size()
	_block_scale.x = _screen_size.x / (block_size.x * columns)
	_block_scale.y = (_screen_size.y / 2) / (block_size.y * rows)

	_offset.x = block_size.x * _block_scale.x
	_offset.y = block_size.y * _block_scale.y


func _on_block_destroyed():
	_block_count -= 1
	if(_block_count == 0):
		print("GAME OVER")
