extends PowerUp

@export var ball_change_speed := 50


func _effect():
	Ball.speed += ball_change_speed


func _on_effect_duration_timeout():
	pass
