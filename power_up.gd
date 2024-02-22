extends RigidBody2D

enum Types {
	CHAOS,
	CONFUSE,
	INCREASE,
	PASSTHROUGH,
	SPEED,
	STICKY,
}

var type_texture = {
	Types.CHAOS: load("res://textures/powerup_chaos.png"),
	Types.CONFUSE: load("res://textures/powerup_confuse.png"),
	Types.INCREASE: load("res://textures/powerup_increase.png"),
	Types.PASSTHROUGH: load("res://textures/powerup_passthrough.png"),
	Types.SPEED: load("res://textures/powerup_speed.png"),
	Types.STICKY: load("res://textures/powerup_sticky.png"),
}

var type: Types

func _ready():
	$Sprite2D.texture = type_texture[Types.CHAOS]
	linear_velocity.y = 150.0


func _physics_process(delta):
	position += linear_velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
