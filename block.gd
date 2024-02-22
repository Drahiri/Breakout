extends StaticBody2D

signal destroyed

@export var solid_block_texture := Texture2D

var block_types = {
	2: Color(0.2, 0.6, 1.0),
	3: Color(0.0, 0.7, 0.0),
	4: Color(0.8, 0.8, 0.4),
	5: Color(1.0, 0.5, 0.0),
}

var is_solid := false
var type: int

func _ready():
	if(type == 1):
		is_solid = true
		$Sprite2D.texture = solid_block_texture
	else:
		modulate = block_types[type]

func get_size():
	return $Sprite2D.texture.get_size()

func destroy():
	if (is_solid):
		return

	queue_free()
	destroyed.emit()
