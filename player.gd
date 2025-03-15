extends KinematicBody2D

# Movement variables
var velocity = Vector2.ZERO
const SPEED = 200
const JUMP_FORCE = -500
const GRAVITY = 1200

# Stair tracking
var current_stair = 0
var last_stair = 0
var score = 0

# Flag to control if player can move
var can_move = true

# Get reference to the game manager
onready var game_manager = get_parent()

func _physics_process(delta):
	if not can_move:
		return
		
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	# Handle horizontal movement
	var horizontal_input = 0
	if Input.is_action_pressed("move_left"):
		horizontal_input -= 1
	if Input.is_action_pressed("move_right"):
		horizontal_input += 1
	
	velocity.x = horizontal_input * SPEED
	
	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	# Apply movement and get collision info
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Check if player is grounded
	if is_on_floor():
		check_current_stair()
	
	# Check if player is falling out of screen
	if position.y > get_viewport_rect().size.y + 50:
		game_manager.game_over()
	
	# Debug: Teleport to stair 199 (for testing win condition)
	if Input.is_action_just_pressed("debug_teleport"):
		current_stair = 199
		game_manager.teleport_to_stair(current_stair)

func check_current_stair():
	# This function will be called when the player lands on a surface
	# We'll need to determine which stair the player is on
	
	# If we're on the ground (stair 0)
	if position.y >= 550:
		handle_stair_change(0)
		return
	
	# Otherwise, determine which stair we're on based on the stair we're colliding with
	var colliding_stair = get_colliding_stair()
	if colliding_stair != null:
		var stair_number = colliding_stair.get_meta("stair_number") if colliding_stair.has_meta("stair_number") else 0
		handle_stair_change(stair_number)

func get_colliding_stair():
	# Get all colliding bodies
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		# Check if this is a stair (not ground)
		if collider.is_in_group("stairs"):
			return collider
	return null

func handle_stair_change(new_stair):
	# If we've landed on a new stair
	if new_stair != current_stair:
		last_stair = current_stair
		current_stair = new_stair
		
		# Check if we've fallen too far
		if last_stair - current_stair >= 3:
			# Fell 3 or more stairs - game over
			game_manager.game_over()
		elif new_stair > last_stair:
			# We've gone up to a new stair
			score += (new_stair - last_stair) * 10
			game_manager.update_score(score)
			
			# Check for win condition
			if current_stair == 200:
				game_manager.win_game()

func stop_movement():
	can_move = false
	velocity = Vector2.ZERO

func resume_movement():
	can_move = true 