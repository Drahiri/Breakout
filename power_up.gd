extends RigidBody2D

signal collected(Types)

enum Types {
	NONE,
	CHAOS,
	CONFUSE,
	INCREASE,
	PASSTHROUGH,
	SPEED,
	STICKY,
}

var _type_texture = {
	Types.CHAOS: {
		"texture": load("res://textures/powerup_chaos.png"),
		"color": Color(0.9, 0.25, 0.25),
	},
	Types.CONFUSE: {
		"texture": load("res://textures/powerup_confuse.png"),
		"color": Color(1.0, 0.3, 0.3),
	},
	Types.INCREASE: {
		"texture": load("res://textures/powerup_increase.png"),
		"color": Color(1.0, 0.6, 0.4)
	},
	Types.PASSTHROUGH:{
		"texture": load("res://textures/powerup_passthrough.png"),
		"color": Color(0.5, 1.0, 0.5),
	},
	Types.SPEED: {
		"texture": load("res://textures/powerup_speed.png"),
		"color": Color(0.5, 0.5, 1.0),
	},
	Types.STICKY: {
		"texture": load("res://textures/powerup_sticky.png"),
		"color": Color(1.0, 0.5, 1.0),
	},
}

var type: Types

func _ready():
	$Sprite2D.texture = _type_texture[type]["texture"]
	modulate = _type_texture[type]["color"]
	linear_velocity.y = 150.0


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(_body):
	queue_free()
	collected.emit(type)
