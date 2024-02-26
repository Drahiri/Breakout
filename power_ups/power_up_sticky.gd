extends PowerUp

func _effect():
	Ball.sticky = true
	modulate = Color(1.0, 0.5, 1.0)
	$EffectDuration.start()


func _on_effect_duration_timeout():
	Ball.sticky = false
	modulate = Color(1.0, 1.0, 1.0)
