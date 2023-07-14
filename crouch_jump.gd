extends base_state

func enter():
	animation_name = "crouch"
	animation_speed = 1.3
	super()
	player.velocity.y = player.jump_speed
	player.standing_collision.disabled = true
	player.crouching_collision.disabled = false
	
func input(event):
	if event.is_action_released("crouch"):
		return states.fall
	if event.is_action_pressed("jump") && Input.is_action_pressed("crouch") && player.air_jump_current > 0:
		player.air_jump_current -= 1
		return states.crouch_jump
	return states.Null
	
func physics_process(delta):
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
	
	if player.is_on_floor() && Input.is_action_pressed("crouch"):
		return states.crouch
	if player.is_on_floor():
		return states.idle
	return states.Null
	
func exit():
	player.standing_collision.disabled = false
	player.crouching_collision.disabled = true
