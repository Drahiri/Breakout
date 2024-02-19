extends StaticBody2D

var isSolid := true
@export var solid_block_texture := Texture2D

func _ready():
	if (isSolid):
		$Sprite2D.texture = solid_block_texture

func destroy():
	if (not isSolid):
		queue_free()
