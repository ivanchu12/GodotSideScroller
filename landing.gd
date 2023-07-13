extends base_state

func enter():
	animation_cond = "parameters/conditions/jump_end"
	animation_speed = 1.5
	super()
	
func input(event):
	if event.is_action_pressed("left") || event.is_action_pressed("right"):
		return states.run

func physics_process(delta):
	if player.velocity == Vector2.ZERO:
		return states.idle
	return states.Null
	
