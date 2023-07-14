extends base_state

func enter():
	animation_name = "jump_end"
	animation_speed = 2
	super()
	
func input(event):
	if event.is_action_pressed("left") || event.is_action_pressed("right"):
		return states.run
	if event.is_action_pressed("crouch"):
		return states.crouch

func physics_process(delta):
	if player.velocity == Vector2.ZERO:
		await player.animation_player.animation_finished
		return states.idle
	return states.Null
	
