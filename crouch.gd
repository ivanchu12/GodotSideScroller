extends base_state

var crouching_speed

func enter():
	animation_name = "crouch"
	animation_speed = 1.3
	super()
	crouching_speed = player.speed / 2
	player.standing_collision.disabled = true
	player.crouching_collision.disabled = false
	player.air_jump_current = player.air_jump_total
	
func input(event):
	if event.is_action_released("crouch"):
		return states.idle
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
	player.velocity.x = direction * crouching_speed
	player.move_and_slide()
	
	if Input.is_action_pressed("crouch") && Input.is_action_pressed("jump"):
		return states.crouch_jump
	if !player.is_on_floor():
		return states.fall
	return states.Null
	
func exit():
	player.standing_collision.disabled = false
	player.crouching_collision.disabled = true
