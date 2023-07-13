extends CharacterBody2D
class_name Player

@export var speed = 400.0
@export var brake_speed = 400
@export var jump_speed = -400.0
@onready var state_manager = $state_manager
@onready var sprite = $Sprite
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var standing_collision = $StandingHitBox
@onready var crouching_collision = $CrouchingHitBox
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var air_jump_total = 1
@onready var air_jump_current = air_jump_total

func _ready():
	animation_tree.active = true
	state_manager.init(self)
	state_manager.change_state(base_state.states.idle)
	
func _physics_process(delta):
	state_manager.physics_process(delta)
	
func _unhandled_input(event):
	state_manager.input(event)
