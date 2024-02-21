extends Node2D

@export var block_scene: PackedScene
@onready var screen_size := get_viewport_rect().size

var block_scale: Vector2
var offset: Vector2

func _ready():
	load_level("res://levels/one.lvl")

func load_level(file_name: String):
	var level_content = FileAccess.get_file_as_string(file_name)
	var rows = level_content.split("\n", false)
	var num_of_rows = len(rows)
	var num_of_columns = len(rows[0].split(" ", false))

	set_level_offsets(num_of_rows, num_of_columns)

	for i in range(num_of_rows):
		var column = rows[i].split(" ", false)
		for j in range(num_of_columns):
			if(column[j] == '0'):
				continue

			var block = block_scene.instantiate()
			block.position = Vector2(offset.x * j, offset.y * i)
			block.scale = block_scale
			block.type = column[j]
			add_child(block)



func set_level_offsets(rows: int, columns: int):
	var block_size = block_scene.instantiate().get_size()
	block_scale.x = screen_size.x / (block_size.x * columns)
	block_scale.y = (screen_size.y / 2) / (block_size.y * rows)

	offset.x = block_size.x * block_scale.x
	offset.y = block_size.y * block_scale.y
