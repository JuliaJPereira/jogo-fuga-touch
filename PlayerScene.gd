extends Area2D

var screen_size
var direction_right = false
var speed = 500
var MIN_PADDING = 45
var MIN_ROTATION = -40
var MAX_ROTATION = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$Death_audio.stream.set_loop(false)
	position.x = MIN_PADDING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.game_initialized:
		if direction_right:
			position.x += delta * speed
			if rotation_degrees < MAX_ROTATION:
				rotation_degrees += delta * 300
		else: 
			position.x -= delta * speed
			if rotation_degrees > MIN_ROTATION:
				rotation_degrees -= delta * 300
			
		if position.x > screen_size.x - MIN_PADDING:
			death_player()
		if position.x < MIN_PADDING:
			death_player()
	
func _unhandled_input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.is_pressed():
			if !Globals.game_initialized:
				inicializa_jogo()
			change_player_direction()
			
func change_player_direction():
	direction_right = !direction_right
	
func death_player():
	$Death_audio.play()
	hide()
	Globals.game_initialized = false
	Globals.game_over = true

func _on_Player_area_entered(area: Area2D):
	if area.is_in_group("enemy"):
		death_player()
		get_tree().call_group("enemy", "destroy")
	pass # Replace with function body.

func inicializa_jogo():
	Globals.game_initialized = true
	Globals.game_over = false
	position.x = MIN_PADDING
	direction_right = false
	show()
