extends RigidBody2D
class_name PowerUp

@onready var Ball = get_node("/root/Main/Ball")
@onready var Paddle = get_node("/root/Main/Paddle")

func _ready():
	linear_velocity.y = 150.0

func _effect():
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(_body):
	_effect()
	queue_free()


func _on_effect_duration_timeout():
	pass # Replace with function body.
