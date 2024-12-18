extends CanvasLayer

class_name UI

@onready var points_label = $MarginContainer/PointsLabel
@onready var game_over_box = $MarginContainer/GameOverBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points_label.text = "%d" % 0

func update_points(points: int):
	points_label.text = "%d" % points

func on_game_over():
	game_over_box.visible = true

func on_button_pressed():
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
