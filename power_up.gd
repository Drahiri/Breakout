extends RigidBody2D

enum TYPES {
	CHAOS,
	CONFUSE,
	INCREASE,
	PASSTHROUGH,
	SPEED,
	STICKY,
}

var type_texture := {
	TYPES.CHAOS: load("res://textures/powerup_chaos.png"),
	TYPES.CONFUSE: load("res://textures/powerup_confuse.png"),
	TYPES.INCREASE: load("res://textures/powerup_increase.png"),
	TYPES.PASSTHROUGH: load("res://textures/powerup_passthrough.png"),
	TYPES.SPEED: load("res://textures/powerup_speed.png"),
	TYPES.STICKY: load("res://textures/powerup_sticky.png"),
}

var type: TYPES

func _ready():
	$Sprite2D.texture = type_texture[TYPES.CHAOS]
	linear_velocity.y = 150.0


func _physics_process(delta):
	position += linear_velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
