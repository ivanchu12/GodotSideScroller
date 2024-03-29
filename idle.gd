extends base_state

func enter():
	animation_name = "idle"
	super()
	player.air_jump_current = player.air_jump_total

func input(event: InputEvent):
	if event.is_action_pressed("right") || event.is_action_pressed("left"):
		return states.run
	if event.is_action_pressed("jump"):
		return states.jump
	if event.is_action_pressed("crouch"):
		return states.crouch
	return states.Null
	
func physics_process(delta):
	if !player.is_on_floor():
		return states.fall
	return states.Null
	
