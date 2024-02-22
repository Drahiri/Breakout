extends Node2D

@export var block_scene: PackedScene
@onready var screen_size := get_viewport_rect().size

var block_count: int
var block_scale: Vector2
var offset: Vector2

func _ready():
	load_level("res://levels/one.lvl")

func _on_block_destroyed():
	block_count -= 1
	if(block_count == 0):
		print("GAME OVER")

func load_level(file_name: String):
	var level_content = FileAccess.get_file_as_string(file_name)
	var rows = level_content.split("\n", false)
	var num_of_rows = len(rows)
	var num_of_columns = len(rows[0].split(" ", false))

	set_level_offsets(num_of_rows, num_of_columns)

	for i in range(num_of_rows):
		var column = rows[i].split(" ", false)
		for j in range(num_of_columns):
			add_block(int(column[j]), Vector2(offset.x * j, offset.y * i))


func add_block(type: int, location: Vector2):
	if(type == 0):
		return

	var block = block_scene.instantiate()
	block.position = location
	block.scale = block_scale
	block.type = type
	block.destroyed.connect(_on_block_destroyed)
	add_child(block)
	if(type != 1):
		block_count += 1


func set_level_offsets(rows: int, columns: int):
	var block_size = block_scene.instantiate().get_size()
	block_scale.x = screen_size.x / (block_size.x * columns)
	block_scale.y = (screen_size.y / 2) / (block_size.y * rows)

	offset.x = block_size.x * block_scale.x
	offset.y = block_size.y * block_scale.y
