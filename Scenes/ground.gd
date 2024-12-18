extends Node2D

class_name Ground

signal bird_crashed

@export var speed = -150

@onready var sprite1 = $Ground1/Sprite2D
@onready var sprite2 = $Ground2/Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta

	# Cuando el sprite1 abandona la pantalla se pone a la derecha del sprite2
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()
	# Cuando el sprite2 abandona la pantalla se pone a la derecha del sprite1
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()


func _on_body_entered(body: Node2D) -> void:
	bird_crashed.emit()
	stop()
	(body as Bird).stop()

func stop():
	speed=0
