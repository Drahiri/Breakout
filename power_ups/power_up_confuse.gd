extends PowerUp

func _effect():
	EffectsManager.confuse_activated.emit()
	$EffectDuration.start()


func _on_effect_duration_timeout():
	EffectsManager.confuse_deactivated.emit()
	queue_free()
