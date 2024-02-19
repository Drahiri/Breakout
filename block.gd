extends StaticBody2D

var isSolid := true
@export var solid_block_texture := Texture2D

func destroy():
	if (not isSolid):
		queue_free()
