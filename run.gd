extends base_state

func enter():
	animation_cond = "run"
	animation_speed = 2
	super()
	player.air_jump_current = player.air_jump_total

func input(event: InputEvent):
	if event.is_action_pressed("jump"):
		return states.jump
	return states.Null
		
func physics_process(delta: float):
	player.velocity.y += player.gravity * delta
	var direction: int = 0
	if Input.is_action_pressed("left"):
		direction = -1
		player.sprite.flip_h = true
	elif Input.is_action_pressed("right"):
		player.sprite.flip_h = false
		direction = 1
	player.velocity.x = direction * player.speed
	player.move_and_slide()
	
	if !direction:
		return states.idle
	if !player.is_on_floor():
		return states.fall
	return states.Null
	
