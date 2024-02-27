extends PowerUp


func _effect():
	$EffectDuration.start()


func _on_effect_duration_timeout():
	queue_free()
