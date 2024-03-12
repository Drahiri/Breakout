extends StaticBody2D

signal destroyed(location: Vector2)

@export var solid_block_texture: Texture2D

enum Types {
	EMPTY,
	SOLID,
	BLUE,
	GREEN,
	YELLOW,
	ORANGE
}

const COLORS := {
	Types.BLUE: Color(0.2, 0.6, 1.0),
	Types.GREEN: Color(0.0, 0.7, 0.0),
	Types.YELLOW: Color(0.8, 0.8, 0.4),
	Types.ORANGE: Color(1.0, 0.5, 0.0),
}

var is_solid := false
var type: Types


func _ready():
	if(type == Types.SOLID):
		is_solid = true
		$Sprite2D.texture = solid_block_texture
	else:
		modulate = COLORS[type]


func get_size():
	return $Sprite2D.texture.get_size()


func destroy():
	queue_free()
	destroyed.emit(position)
