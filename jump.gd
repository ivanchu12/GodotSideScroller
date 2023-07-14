extends base_state


func enter():
	animation_name = "jump"
	animation_speed = 2
	super()
	player.velocity.y = player.jump_speed

func input(event):
	if event.is_action_pressed("jump") && player.air_jump_current > 0:
		player.air_jump_current -= 1
		return states.jump
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
	
	if player.velocity.y >= 0:
		return states.fall
	return states.Null

