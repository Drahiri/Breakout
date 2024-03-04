extends PowerUp

func _effect():
	EffectsManager.active_passthrough += 1
	EffectsManager.passthrough_activated.emit()
	$EffectDuration.start()


func _on_effect_duration_timeout():
	EffectsManager.active_passthrough -= 1
	if EffectsManager.active_passthrough == 0:
		EffectsManager.passthrough_deactivated.emit()
	queue_free()
