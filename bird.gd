extends CharacterBody2D

class_name Bird

signal game_started

@export var gravitiy = 980.0
@export var jump_force = -350
@export var rotation_speed = 2

@onready var animation_player = $AnimationPlayer
@onready var fly_sound = $Wing

var max_speed = 400
var is_started = false
var should_process_input = true


func _ready() -> void:
	velocity = Vector2.ZERO
	animation_player.play("idle")
	

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started:
			game_started.emit()
			animation_player.play("flap_wings")
			is_started = true
		jump()
		
	
	if !is_started:
		return
	
	velocity.y += gravitiy * delta
	
	velocity.y = min(velocity.y, max_speed)
	
	if velocity.y > max_speed:
		velocity.y = max_speed
		
	move_and_collide(velocity * delta)
	rotate_bird()

func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
	fly_sound.play()
	animation_player.play("flap_wings")


func rotate_bird():
	# Rotar hacia abajo cuando cae
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	# Rotar hacia arriba cuando se levanta
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func stop():
	animation_player.stop()
	gravitiy = 0
	velocity = Vector2.ZERO
	should_process_input = false

func kill():
	should_process_input = false

"""
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
"""
