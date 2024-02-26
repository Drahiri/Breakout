extends PowerUp

@export var increase_size_multiplier := 1.5

func _effect():
	Paddle.scale.x *= increase_size_multiplier


func _on_effect_duration_timeout():
	pass
