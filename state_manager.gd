extends Node

@onready var states = {
	base_state.states.idle: $idle,
	base_state.states.run: $run,
	base_state.states.fall: $fall,
	base_state.states.landing: $landing,
	base_state.states.jump: $jump
}

var current_state

func change_state(new_state):
	if current_state:
		current_state.exit()
	current_state = self.states[new_state]
	current_state.enter()
	
func init(player):
	for child in get_children():
		child.player = player
		
func physics_process(delta):
	var new_state = current_state.physics_process(delta)
	if new_state != base_state.states.Null:
		change_state(new_state)
		
func input(event):
	var new_state = current_state.input(event)
	if new_state != base_state.states.Null && new_state:
		change_state(new_state)
