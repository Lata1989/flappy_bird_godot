extends Node

class_name Fade

@onready var animation_player = $AnimationPlayer
@onready var color_rect = $ColorRect


func _ready() -> void:
	color_rect.visible = false  # Asegúrate de que sea invisible al inicio

func play():
	color_rect.visible = true   # Mostrar el ColorRect cuando empieza la animación
	animation_player.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
"""
func _ready() -> void:
	color_rect.visible = false  # Asegúrate de que sea invisible al inicio

func play():
	color_rect.visible = true   # Mostrar el ColorRect cuando empieza la animación
	animation_player.play()

func hide_after_fade():
	color_rect.visible = false  # Ocultar el ColorRect al finalizar la animación
"""
