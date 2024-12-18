extends Node

@onready var bird = $"../Bird" as Bird
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var ground = $"../Ground" as Ground
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI
@onready var play_song = $GameSong
@onready var death_song = $DeathSong

var points : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(on_end_game)
	pipe_spawner.bird_crashed.connect(on_end_game)
	pipe_spawner.point_scored.connect(on_point_scored)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	pass

func on_game_started():
	pipe_spawner.start_spawning_pipes()
	play_song.play()

func on_end_game():
	if (fade != null):
		fade.play()
		ground.stop()
		pipe_spawner.stop()
		play_song.stop()
		bird.kill()
		death_song.play()
		ui.on_game_over()

func on_point_scored():
	points += 1
	ui.update_points(points)
