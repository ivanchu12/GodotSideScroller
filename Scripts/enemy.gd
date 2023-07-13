extends CharacterBody2D

@export var speed = 100.0
@onready var animation_tree = $AnimationTree
var direction = Vector2.ZERO
enum states{
	idle,
	walk,
	run
} 
var current_state = states.idle
@onready var timer = $Timer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _process(delta):
	match current_state:
		states.idle:
			animation_tree["parameters/conditions/idle"] = true
		states.walk:
			animation_tree["parameters/conditions/walk"] = true
		states.run:
			animation_tree["parameters/conditions/run"] = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement():
	velocity.x = 1 * speed
	
func handle_animations():
	animation_tree["parameters/conditions/idle"] = true

func _on_timer_timeout():
	var time_intervals = [0.5, 1, 1.5, 2]
	timer.wait_time = time_intervals[randi() % time_intervals.lenght]
	current_state = states[]
