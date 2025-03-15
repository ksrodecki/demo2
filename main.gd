extends Node2D

# Stair generation variables
const STAIR_SCENE = preload("res://stair.tscn")
const STAIR_COUNT = 200
const MIN_STAIR_WIDTH = 50
const MAX_STAIR_WIDTH = 150
const MIN_STAIR_GAP = 50
const MAX_STAIR_GAP = 100
const STAIR_HEIGHT = 20

# Game state
var game_state = "playing" # playing, game_over, won
var speed_multiplier = 1.0
var stairs = []

# UI references
onready var score_label = $UI/ScoreLabel
onready var game_over_panel = $UI/GameOverPanel
onready var win_panel = $UI/WinPanel
onready var player = $Player
onready var camera = $Camera2D

func _ready():
	# Hide UI panels at start
	game_over_panel.visible = false
	win_panel.visible = false
	
	# Generate stairs
	generate_stairs()
	
	# Start with player on ground (stair 0)
	player.position = Vector2(400, 550)
	
	# Initialize score
	update_score(0)

func _process(delta):
	# Update camera position to follow player
	if game_state == "playing":
		camera.position.y = min(player.position.y, camera.position.y)
		
		# Increase speed over time
		speed_multiplier += delta * 0.01
	
	# Handle restart input
	if game_state != "playing" and Input.is_action_just_pressed("restart"):
		restart_game()

func generate_stairs():
	# First create the ground (stair 0)
	var ground = StaticBody2D.new()
	ground.add_to_group("ground")
	add_child(ground)
	
	var ground_collision = CollisionShape2D.new()
	var ground_shape = RectangleShape2D.new()
	ground_shape.extents = Vector2(400, 25)
	ground_collision.shape = ground_shape
	ground_collision.position = Vector2(400, 575)
	ground.add_child(ground_collision)
	
	# Generate all stairs (1 to STAIR_COUNT)
	var prev_y = 450  # Start just above ground
	
	for i in range(1, STAIR_COUNT + 1):
		var stair = STAIR_SCENE.instance()
		add_child(stair)
		
		# Randomize width and create shape
		var width = rand_range(MIN_STAIR_WIDTH, MAX_STAIR_WIDTH)
		var shape = RectangleShape2D.new()
		shape.extents = Vector2(width / 2, STAIR_HEIGHT / 2)
		stair.get_node("CollisionShape2D").shape = shape
		
		# Randomize position
		var x_pos = rand_range(width / 2, 800 - width / 2)
		var y_gap = rand_range(MIN_STAIR_GAP, MAX_STAIR_GAP)
		var y_pos = prev_y - y_gap
		stair.position = Vector2(x_pos, y_pos)
		
		# Store stair number as metadata
		stair.set_meta("stair_number", i)
		
		# Add to stairs array
		stairs.append(stair)
		
		# Update prev_y for next stair
		prev_y = y_pos
		
		# Make the top stair gold-colored
		if i == STAIR_COUNT:
			# In a real implementation, we'd add a special sprite or color here
			# For now, just add a label to indicate it's the top
			var top_label = Label.new()
			top_label.text = "TOP"
			top_label.rect_position = Vector2(-20, -30)
			stair.add_child(top_label)

func game_over():
	if game_state != "playing":
		return
		
	game_state = "game_over"
	player.stop_movement()
	game_over_panel.visible = true

func win_game():
	if game_state != "playing":
		return
		
	game_state = "won"
	player.stop_movement()
	win_panel.visible = true

func restart_game():
	# Simply reload the current scene
	get_tree().reload_current_scene()

func update_score(new_score):
	score_label.text = "Score: " + str(new_score)

func teleport_to_stair(stair_number):
	# Debug function to teleport player to a specific stair
	if stair_number < 0 or stair_number >= stairs.size():
		return
		
	var target_stair = stairs[stair_number - 1]  # -1 because stairs array is 0-indexed
	player.position = Vector2(target_stair.position.x, target_stair.position.y - 40)  # 40 is player height
	player.current_stair = stair_number 