extends PowerUp


func _effect():
	Ball.passthrough = true
	modulate = Color(1.0, 0.5, 0.5)


func _on_effect_duration_timeout():
	Ball.passthrough = false
	modulate = Color(1.0, 1.0, 1.0)
