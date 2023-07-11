extends CharacterBody2D


@export var speed = 400.0
@export var brake_speed = 400
@export var jump_velocity = -400.0
@onready var animatedSprite = $Sprite
@onready var standing_collision = $StandingHitBox
@onready var crouching_collision = $CrouchingHitBox
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var air_jump_total = 2
var air_jump_current = air_jump_total
var is_crouching = false
var actions = {"left": false, "right": false, "crouch": false, "jump": false}
var animations = {"idle": false, "run": false, "jump_start": false, "jump_end": false}
var animation_flip = false
var is_landing = false


func _ready():
	crouching_collision.disabled = true
	animatedSprite.play("idle")
	
func _physics_process(delta):
	if is_on_floor():
		air_jump_current = air_jump_total
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y >= 0:
			is_landing = true
	if is_landing:
		reset_animation()
		animations["jump_end"] = true
		is_landing = false
	handle_input()
	handle_actions()
	handle_release()
	move_and_slide()
	play_current_animation()
	reset_input()
	
func handle_input():
	if Input.is_action_just_pressed("jump"):
		actions["jump"] = true
	if Input.is_action_pressed("left"):
		actions["left"] = true
	if Input.is_action_pressed("right"):
		actions["right"] = true
	if Input.is_action_pressed("crouch"):
		actions["crouch"] = true
		
func handle_release():
	if Input.is_action_just_released("crouch"):
		speed = 300
		standing_collision.disabled = false
		crouching_collision.disabled = true
		is_crouching = false
	if Input.is_action_just_released("left") || Input.is_action_just_released("right"):
		velocity.x = move_toward(velocity.x, 0, brake_speed)
		if !velocity.x && is_on_floor():
			reset_animation()
			animations["idle"] = true
	
func reset_animation():
	for key in animations:
		animations[key] = false
	
func play_current_animation():
	if animation_flip:
		animatedSprite.flip_h = true
	else:
		animatedSprite.flip_h = false
	for key in animations:
		if animations[key]:
			animatedSprite.play(key)
	
func handle_actions():
	if actions["jump"]:
		handle_jump()
	if actions["left"]:
		handle_movement(-1)
	if actions["right"]:
		handle_movement(1)
	if actions["crouch"]:
		handle_crouching()

func reset_input():
	for key in actions:
		actions[key] = false

func handle_movement(direction):
	velocity.x = direction * speed
	if direction < 0:
		animation_flip = true
	else:
		animation_flip = false
	reset_animation()
	animations["run"] = true
	
func handle_crouching():
	crouching_collision.disabled = false
	standing_collision.disabled = true
	speed = 150
	is_crouching = true

func handle_jump():
	if !is_crouching:
		if is_on_floor():
			velocity.y = jump_velocity
		elif !is_on_floor() && air_jump_current:
			velocity.y = jump_velocity
			air_jump_current -= 1
