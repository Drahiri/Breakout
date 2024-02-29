extends PowerUp

@onready var confuse_effect = get_node("/root/Main/Effects/Confuse")

func _effect():
	$EffectDuration.start()
	confuse_effect.show()


func _on_effect_duration_timeout():
	confuse_effect.hide()
	queue_free()
