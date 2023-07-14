extends CharacterBody2D

@export var walk_speed = 10.0
@export var run_speed = 20.0

var direction = Vector2.RIGHT

var time_intervals = [0.5, 1, 1.5, 2]
var directions_array = [Vector2.RIGHT, Vector2.LEFT]

enum states{
	idle,
	walk,
	run
}

@export var current_state = states.idle
@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	pass
	timer.start(1)

func _process(delta):
	match current_state:
		states.idle:
			animation_player.play("idle")
			idle_state()
		states.walk:
			animation_player.play("walk")
			walk_state()
		states.run:
			animation_player.play("run")
			run_state()

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func _on_timer_timeout():
	timer.wait_time = time_intervals[randi() % time_intervals.size()]
	current_state = states.values()[randi() % states.size()]
	direction = directions_array[randi() % directions_array.size()]
	if direction == Vector2.RIGHT:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
func idle_state():
	velocity.x = 0
	
func walk_state():
	velocity.x = direction.x * walk_speed
	
func run_state():
	velocity.x = direction.x * run_speed
